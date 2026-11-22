{ pkgs, secrets, ... }:
let
  # Pinned: palace/index formats change between releases, upgrade deliberately.
  image = "ghcr.io/mempalace/mempalace:3.12.0";
  port = 8765;

  dataDir = "/var/lib/mempalace";
  # Agent transcripts arrive here via Syncthing from the workstations
  # (folders accepted under <storage>/agent-transcripts/<host>/<harness>).
  inboxDir = "/var/lib/syncthing/storage/agent-transcripts";
in
{
  virtualisation.podman.enable = true;

  systemd.tmpfiles.rules = [
    "d ${dataDir}  0755 sano users - -"
    "d ${inboxDir} 0755 sano users - -"
  ];

  # Shared-brain hub: single writer for the palace; Claude Code and Antigravity on
  # every workstation connect over LAN as remote MCP clients with a bearer token.
  virtualisation.oci-containers.containers.mempalace = {
    inherit image;
    # Entrypoint forwards unknown args to the `mempalace` CLI.
    cmd = [
      "serve"
      "--host"
      "0.0.0.0"
      "--port"
      (toString port)
    ];

    volumes = [
      "${dataDir}:/data:Z"
      "${inboxDir}:/inbox:ro,z"
    ];

    environment = {
      MEMPALACE_MCP_HTTP_TOKEN = secrets.mempalace.token;
      # Always-on hub: don't exit when idle.
      MEMPALACE_MCP_IDLE_HOURS = "0";
      # Multilingual (ru/en). Changing it later needs `mempalace repair rebuild-index`.
      MEMPALACE_EMBEDDING_MODEL = "embeddinggemma";
      # ONNX grabs every core by default and cooks the mac mini during backfills.
      MEMPALACE_EMBEDDING_THREADS = "2";
    };

    extraOptions = [
      "--cpus=2"
      "--user=1000:100"
      "--publish=${toString port}:${toString port}"
    ];
  };

  networking.firewall.allowedTCPPorts = [ port ];

  systemd.services.podman-mempalace = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };

  # Mine synced transcripts into the palace. Mining is idempotent (unchanged
  # files are skipped) and inside the container it is handed to the running hub.
  systemd.services.mempalace-mine = {
    description = "Mine synced agent transcripts into MemPalace";
    after = [ "podman-mempalace.service" ];
    requires = [ "podman-mempalace.service" ];
    serviceConfig.Type = "oneshot";
    path = [ pkgs.podman ];
    # Layout: <host>/<agent>/<project-slug>/..., where the slug is the project path
    # with "/" -> "-" (Claude's ~/.claude/projects convention, mirrored by the
    # Antigravity exporter). One wing per project, shared by all hosts and agents.
    script = ''
      shopt -s nullglob
      for dir in ${inboxDir}/*/*/*/; do
        dir=''${dir%/}
        wing=''${dir##*/}
        wing=''${wing#-home-${secrets.user.username}}
        wing=''${wing#-}
        wing=''${wing#Projects-}
        wing=''${wing:-home}
        wing=''${wing// /_}
        podman exec mempalace mempalace mine "/inbox/''${dir#${inboxDir}/}" \
          --mode convos --wing "$wing" || true
      done
    '';
  };

  systemd.timers.mempalace-mine = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "30min";
    };
  };
}
