"""Export Antigravity CLI conversations to MemPalace-friendly transcripts.

agy keeps each conversation as a SQLite file whose steps are protobuf blobs
(no published schema). Only the fields needed for a transcript are read:

  step_type 14 (user input):     19.2  prompt text, 19.12.12 workspace URI
  step_type 15 (model response): 20.1  final answer (20.3 is reasoning, skipped)

Output: <out>/<workspace-slug>/<conversation-id>.md in the "> user" plain-text
format that `mempalace mine --mode convos` passes through as-is.
"""

import os
import sqlite3
import sys
import tempfile
from pathlib import Path
from urllib.parse import unquote, urlparse

USER_STEP = 14
MODEL_STEP = 15


def varint(b, i):
    result = shift = 0
    while True:
        c = b[i]
        i += 1
        result |= (c & 0x7F) << shift
        shift += 7
        if c < 0x80:
            return result, i


def fields(b):
    """Yield (field_number, bytes) for length-delimited fields of a message."""
    i = 0
    while i < len(b):
        key, i = varint(b, i)
        num, wire = key >> 3, key & 7
        if wire == 0:
            _, i = varint(b, i)
        elif wire == 1:
            i += 8
        elif wire == 5:
            i += 4
        elif wire == 2:
            n, i = varint(b, i)
            yield num, b[i:i + n]
            i += n
        else:
            raise ValueError(f"unsupported wire type {wire}")


def get(b, *path):
    """First value at a field path, or None."""
    for num, val in fields(b):
        if num == path[0]:
            return val if len(path) == 1 else get(val, *path[1:])
    return None


def text(b, *path):
    try:
        val = get(b, *path)
        return val.decode("utf-8").strip() if val else ""
    except (ValueError, IndexError, UnicodeDecodeError):
        return ""


def body_lines(s):
    # A line starting with ">" marks a user turn for mempalace; pasted logs and
    # quotes inside messages must not, so escape them markdown-style.
    return [("\\" + ln) if ln.lstrip().startswith(">") else ln for ln in s.split("\n")]


def slug(workspace):
    # Same convention as ~/.claude/projects: /home/me/x -> -home-me-x
    return workspace.replace("/", "-").replace(".", "-") or "unknown"


def convert(db_path):
    uri = f"file:{db_path}?mode=ro"
    with sqlite3.connect(uri, uri=True) as db:
        rows = db.execute(
            "SELECT step_type, step_payload FROM steps"
            " WHERE step_type IN (?, ?) ORDER BY idx",
            (USER_STEP, MODEL_STEP),
        ).fetchall()

    workspace = ""
    turns = []  # [(user_text, [answers])]
    for step_type, payload in rows:
        if not payload:
            continue
        if step_type == USER_STEP:
            prompt = text(payload, 19, 2)
            if prompt:
                turns.append((prompt, []))
            ws = text(payload, 19, 12, 12)
            if ws and not workspace:
                workspace = unquote(urlparse(ws).path)
        else:
            answer = text(payload, 20, 1)
            if answer and turns:
                turns[-1][1].append(answer)

    if not turns:
        return None, None

    lines = [f"# Antigravity conversation {Path(db_path).stem}"]
    if workspace:
        lines.append(f"Workspace: {workspace}")
    lines.append("")
    for prompt, answers in turns:
        first, *rest = body_lines(prompt)
        lines.append("> " + first.removeprefix("\\"))
        lines.extend(rest)
        for answer in answers:
            lines.extend(body_lines(answer))
        lines.append("")
    return slug(workspace), "\n".join(lines)


def main():
    src = Path(sys.argv[1]).expanduser()
    out = Path(sys.argv[2]).expanduser()
    for db_path in sorted(src.glob("*.db")):
        mtime = db_path.stat().st_mtime
        try:
            project, body = convert(db_path)
        except (sqlite3.Error, ValueError, IndexError) as e:
            print(f"skip {db_path.name}: {e}", file=sys.stderr)
            continue
        if body is None:
            continue
        target = out / project / f"{db_path.stem}.md"
        if target.exists() and target.stat().st_mtime >= mtime:
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        fd, tmp = tempfile.mkstemp(dir=target.parent, suffix=".tmp")
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            f.write(body)
        os.utime(tmp, (mtime, mtime))
        os.replace(tmp, target)


if __name__ == "__main__":
    main()
