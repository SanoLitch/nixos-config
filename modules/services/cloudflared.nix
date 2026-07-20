{ pkgs, ... }: {
  virtualisation.oci-containers.containers.cloudflared = {
    image = "docker.io/cloudflare/cloudflared:latest";

    extraOptions = [ "--network=host" ];

    environment = {
      TUNNEL_TOKEN = "eyJhIjoiOTY0ZjAzMTM1MDcxOWUzODgxM2E3OGJhODQzMjEwYWIiLCJ0IjoiYjgwYzYwMTEtZWNmMi00M2ZkLWJmNzctOWUwNWI1YTI2YjAxIiwicyI6IllUbGpaV0V4TWpNdE5HSTVZaTAwWkRnNExXRmxNREV0TVRjd01UWTVORE5sTkRVMyJ9";
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
