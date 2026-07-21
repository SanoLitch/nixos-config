{ ... }: {
  virtualisation.podman.enable = true;

  systemd.tmpfiles.rules = [
    "d /var/lib/syncthing         0755 sano users - -"
    "d /var/lib/syncthing/config  0755 sano users - -"
    "d /var/lib/syncthing/storage 0755 sano users - -"
  ];

  virtualisation.oci-containers.containers.syncthing = {
    image = "docker.io/syncthing/syncthing:latest";

    volumes = [
      "/var/lib/syncthing/config:/var/syncthing/config:Z"
      "/var/lib/syncthing/storage:/var/syncthing/data:Z"
    ];

    extraOptions = [
      "--network=host"
      "--label=io.containers.autoupdate=registry"
    ];

    environment = {
      PUID = "1000";
      PGID = "1000";
    };
  };

  networking.firewall.allowedTCPPorts = [
    8384
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
  ];

  systemd.services.podman-syncthing = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
