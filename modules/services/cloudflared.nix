{ pkgs, secrets, ... }: {
  virtualisation.oci-containers.containers.cloudflared = {
    image = "docker.io/cloudflare/cloudflared:latest";

    extraOptions = [ "--network=host" ];

    environment = {
      TUNNEL_TOKEN = secrets.cloudflared.token;
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
