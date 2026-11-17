#!/usr/bin/env python3
import os
import sys
import shutil
import struct
import stat
import argparse

SEARCH_PATHS = [
    os.path.expanduser("~/.devbox/nix/profile/default/bin/agy"),
    os.path.expanduser("~/.nix-profile/bin/agy"),
    os.path.expanduser("~/.local/bin/agy"),
    f"/etc/profiles/per-user/{os.environ.get('USER', '')}/bin/agy",
    "/run/current-system/sw/bin/agy",
    "/usr/local/bin/agy",
    "/usr/bin/agy",
]

def find_binary():
    agy_path = shutil.which("agy")
    if agy_path:
        return agy_path

    for path in SEARCH_PATHS:
        if os.path.isfile(path) and os.access(path, os.X_OK):
            return path
        
    return None

def scan_gate1(data):
    """
    Scans for the primary eligibility check API gate (Linux x86_64 ELF).
    Returns (patch_tuple, is_already_patched) where patch_tuple is (offset, new_bytes) or None.
    """
    n = len(data)
    target_str = b'Eligibility check failed:'
    str_offsets = []
    idx = 0
    while True:
        pos = data.find(target_str, idx)
        if pos == -1:
            break
        str_offsets.append(pos)
        idx = pos + 1

    if not str_offsets:
        return None, False

    # Opcode patterns for `test reg, reg`
    # Standard 64-bit registers: rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi (48 85 c0..ff)
    # Extended 64-bit registers: r8 .. r15 (4d 85 c0..ff)
    test_opcodes = [bytes([0x48, 0x85, 0xc0 + i * 9]) for i in range(8)] + \
                   [bytes([0x4d, 0x85, 0xc0 + i * 9]) for i in range(8)]

    # 1. Check if already patched:
    # Replaces `test reg, reg; jne <error>` with `test reg, reg; jmp <success>; nop`
    for test_op in test_opcodes:
        idx = 0
        while True:
            idx = data.find(test_op + b'\xe9', idx)
            if idx == -1:
                break
            patch_offset = idx + len(test_op)
            if patch_offset + 6 <= n and data[patch_offset + 5] == 0x90:
                rel32 = struct.unpack('<i', data[patch_offset + 1:patch_offset + 5])[0]
                dest = patch_offset + 5 + rel32
                if 0 <= dest < n - 0x100:
                    if b'consumer' in data[dest:dest + 0x100]:
                        return None, True
            idx += 1

    # 2. Look for unpatched gate:
    # `test reg, reg` followed by `jne <error_handler>` (0f 85 rel32)
    for test_op in test_opcodes:
        idx = 0
        while True:
            idx = data.find(test_op + b'\x0f\x85', idx)
            if idx == -1:
                break
            patch_offset = idx + len(test_op)
            rel32 = struct.unpack('<i', data[patch_offset + 2:patch_offset + 6])[0]
            if 0x100 < rel32 < 0x800:
                error_target = patch_offset + 6 + rel32
                if 0 <= error_target < n - 0x200:
                    target_chunk = data[error_target:error_target + 0x200]
                    # Check for RIP-relative LEA referencing any eligibility string
                    has_str_ref = False
                    for off in range(0, len(target_chunk) - 7):
                        if target_chunk[off:off + 2] == b'\x48\x8d' and (target_chunk[off + 2] & 0xc7 == 0x05):
                            disp = struct.unpack('<i', target_chunk[off + 3:off + 7])[0]
                            lea_dest = (error_target + off) + 7 + disp
                            if any(abs(lea_dest - s) < 0x80 for s in str_offsets):
                                has_str_ref = True
                                break

                    if has_str_ref:
                        # Find forward jump to success block in chunk_after
                        chunk_after = data[patch_offset + 6:patch_offset + 6 + 64]
                        for i in range(len(chunk_after) - 6):
                            if chunk_after[i:i + 2] in (b'\x0f\x84', b'\x0f\x85'):
                                jmp_rel = struct.unpack('<i', chunk_after[i + 2:i + 6])[0]
                                inst_addr = patch_offset + 6 + i
                                dest = inst_addr + 6 + jmp_rel
                                if dest > patch_offset + 0x100 and b'consumer' in data[dest:dest + 0x100]:
                                    success_rel32 = dest - (patch_offset + 5)
                                    new_bytes = b'\xe9' + struct.pack('<i', success_rel32) + b'\x90'
                                    return (patch_offset, new_bytes), False
            idx += 1

    return None, False

def scan_gate2(data):
    """
    Scans for the TUI local input loop eligibility gate (Linux x86_64 ELF).
    Returns (patch_tuple, is_already_patched) where patch_tuple is (offset, new_bytes) or None.
    """
    n = len(data)
    tui_pattern = b'\x41\x80\x3c\x24\x00'  # cmpb $0x0, (%r12)
    idx = 0
    while True:
        idx = data.find(tui_pattern, idx)
        if idx == -1 or idx > n - 25:
            break

        # Check if already patched:
        if (data[idx + 5:idx + 6] == b'\xe9' and data[idx + 10:idx + 11] == b'\x90') or data[idx + 5:idx + 11] == b'\x90' * 6:
            after_patch = idx + 11
            if (data[after_patch] == 0x90 and data[after_patch + 1:after_patch + 3] == b'\x48\x8d') or data[after_patch:after_patch + 2] == b'\x48\x8d':
                return None, True

        if data[idx + 5:idx + 7] == b'\x0f\x85':
            rel32 = struct.unpack('<i', data[idx + 7:idx + 11])[0]
            after_jne = idx + 11

            if rel32 > 0 and data[after_jne] == 0x90 and data[after_jne + 1:after_jne + 3] == b'\x48\x8d':
                patch_offset = idx + 5
                new_rel32 = rel32 + 1
                new_inst_bytes = b'\xe9' + struct.pack('<i', new_rel32) + b'\x90'
                return (patch_offset, new_inst_bytes), False

            if data[after_jne:after_jne + 3] in (b'\x48\x8d\x05', b'\x48\x8d\x1d'):
                patch_offset = idx + 5
                new_inst_bytes = b'\x90' * 6
                return (patch_offset, new_inst_bytes), False

        idx += 1

    return None, False

def scan_binary_for_pattern(data):
    """
    Fast-scans binary data for the eligibility check gates (Linux x86_64 ELF).
    Returns list of (patch_offset, new_inst_bytes) tuples, or already_patched boolean.
    """
    patches = []

    gate1, gate1_patched = scan_gate1(data)
    gate2, gate2_patched = scan_gate2(data)

    if gate1:
        patches.append(gate1)
    if gate2:
        patches.append(gate2)

    already_patched = len(patches) == 0 and (gate1_patched or gate2_patched)
    return patches, already_patched

def patch_binary(filepath, output_path=None, backup=True):
    real_path = os.path.realpath(filepath)
    is_read_only = not os.access(real_path, os.W_OK)

    if output_path:
        target_filepath = os.path.abspath(output_path)
    elif is_read_only:
        target_filepath = os.path.abspath("./agy_patched")
        print(f"[*] Read-only source detected: {real_path}")
        print(f"[*] Target output path set to: {target_filepath}")
    else:
        target_filepath = real_path

    if target_filepath != real_path:
        print(f"[*] Copying binary to: {target_filepath}")
        shutil.copy2(real_path, target_filepath)
        st = os.stat(target_filepath)
        os.chmod(target_filepath, st.st_mode | stat.S_IWUSR | stat.S_IXUSR)
    elif is_read_only:
        try:
            st = os.stat(target_filepath)
            os.chmod(target_filepath, st.st_mode | stat.S_IWUSR | stat.S_IXUSR)
        except OSError:
            pass

    backup_path = target_filepath + ".bak"
    scan_filepath = target_filepath
    if backup and os.path.exists(backup_path):
        print(f"[*] Scanning backup file: {backup_path}")
        scan_filepath = backup_path

    print(f"[*] Reading binary: {scan_filepath}")
    with open(scan_filepath, 'rb') as f:
        data = bytearray(f.read())

    patches, already_patched = scan_binary_for_pattern(data)

    if already_patched:
        print("ℹ️ Binary is already patched.")
        return True

    if not patches:
        print("❌ Error: Eligibility check pattern not found in binary.")
        return False

    # Create backup if in-place patching and backup is enabled
    if backup and target_filepath == real_path and not os.path.exists(backup_path):
        print(f"[*] Creating backup: {backup_path}")
        shutil.copy2(target_filepath, backup_path)

    # Apply patches
    with open(target_filepath, 'r+b') as f:
        for offset, new_bytes in patches:
            print(f"[*] Applying patch at offset 0x{offset:x} ({len(new_bytes)} bytes)...")
            f.seek(offset)
            f.write(new_bytes)

    print("✅ Patch applied successfully.")
    print("\n🎉 Run the patched client with:")
    print(f"   AGY_CLI_DISABLE_AUTO_UPDATE=true {target_filepath}")

    return True

def main():
    parser = argparse.ArgumentParser(description="Antigravity CLI Eligibility Patcher for Linux (x86_64)")
    parser.add_argument("binary", nargs="?", help="Path to agy binary (optional)")
    parser.add_argument("-o", "--output", help="Output path for patched binary")
    parser.add_argument("--no-backup", action="store_true", help="Do not create a .bak backup file")
    args = parser.parse_args()

    target = args.binary or find_binary()

    if not target:
        print("❌ Error: agy binary not found in default paths.")
        print("Please specify the path to your agy binary:")
        print("  python3 patch_antigravity.py /path/to/agy")
        sys.exit(1)

    if not os.path.exists(target):
        print(f"❌ Error: File not found: {target}")
        sys.exit(1)

    success = patch_binary(target, args.output, backup=not args.no_backup)
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()
