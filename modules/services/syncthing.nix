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
      "--userns=keep-id"
      "--label=io.containers.autoupdate=registry"
      "--security-opt=seccomp=unconfined"
      "--security-opt=apparmor=unconfined"
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
    overrideStrategy = "asDropin";
    serviceConfig = {
      ProtectSystem = "no";
      ProtectHome = "no";
      PrivateDevices = "no";
      ProtectControlGroups = "no";
      ProtectKernelModules = "no";
      ProtectKernelTunables = "no";
      RestrictAddressFamilies = "";
    };
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "local-fs.target"
    ];
  };
}
