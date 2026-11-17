{
  config,
  osConfig,
  pkgs,
  lib,
  secrets,
  ...
}:
# Client side of MemPalace. The palace, embeddings and hub run on mac-mini
# (modules/services/mempalace.nix); workstations only talk MCP over LAN and ship
# their agent transcripts to the server through Syncthing.
let
  version = "3.12.0";
  src = pkgs.fetchFromGitHub {
    owner = "MemPalace";
    repo = "mempalace";
    tag = "v${version}";
    hash = "sha256-WY2OcU/gpJHNOYcA3A1uILTyELL0yUY5PuCbGh11Ask=";
  };

  hubUrl = "http://${secrets.mempalace.host}:8765/mcp";
  hostName = osConfig.networking.hostName;
in
{
  # Recall skill is pure MCP; the setup/task skills assume a local `mempalace` CLI.
  home.file.".claude/skills/mempalace-recall".source =
    "${src}/.claude-plugin/skills/mempalace-recall";

  # Send-only: the server keeps (and mines) the copies.
  services.syncthing.settings.folders."agent-transcripts-${hostName}-claude" = {
    label = "agent-transcripts/${hostName}/claude";
    path = "${config.home.homeDirectory}/.claude/projects";
    devices = [ "mac-mini-server" ];
    type = "sendonly";
  };

  # ~/.claude.json and ~/.claude/settings.json are rewritten by Claude Code itself,
  # so register through the CLI / patch keys instead of symlinking read-only files.
  home.activation.mempalaceClaude = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    claude="${config.home.profileDirectory}/bin/claude"
    if [ -x "$claude" ]; then
      "$claude" mcp remove --scope user mempalace >/dev/null 2>&1 || true
      run "$claude" mcp add --scope user --transport http mempalace "${hubUrl}" \
        --header "Authorization: Bearer ${secrets.mempalace.token}" >/dev/null
    fi

    # Claude Code deletes transcripts after 30 days by default; keep them until
    # Syncthing has shipped them to the server.
    settings="$HOME/.claude/settings.json"
    [ -s "$settings" ] || echo '{}' > "$settings"
    tmp="$(mktemp)"
    ${lib.getExe pkgs.jq} '.cleanupPeriodDays = 365' "$settings" > "$tmp" && mv "$tmp" "$settings"
  '';
}
