{ pkgs, ... }: {
  virtualisation.oci-containers.containers.cloudflared = {
    image = "docker.io/cloudflare/cloudflared:latest";

    extraOptions = [ "--network=host" ];

    environment = {
      TUNNEL_TOKEN = "eyJhIjoiOTY0ZjAzMTM1MDcxOWUzODgxM2E3OGJhODQzMjEwYWIiLCJ0IjoiYWEyMTNhYjEtZGI2Ny00OTE4LTgyNDYtYWQ5NTRhNmMyNTA1IiwiYyI6IlkyVmtZV0k1TkdZdE0ySmxOaTAwT1RBMkxUZzRNVFV0TURSak1EUmlNemhrWmpZeiJ9";
      TUNNEL_TRANSPORT_PROTOCOL = "http2";
    };

    cmd = [
      "tunnel"
      "--no-autoupdate"
      "run"
    ];
  };

  systemd.services.podman-cloudflared = {
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      # "podman-forgejo.service"
    ];
  };
}
