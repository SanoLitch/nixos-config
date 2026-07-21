{ ... }: {
  virtualisation.podman.enable = true;

  systemd.tmpfiles.rules = [
    "d /var/lib/torrserver          0755 sano users - -"
    "d /var/lib/torrserver/torrents 0755 sano users - -"
    "d /var/lib/torrserver/config   0755 sano users - -"
  ];

  virtualisation.oci-containers.containers.torrserver = {
    image = "ghcr.io/yourok/torrserver:latest";

    volumes = [
      "/var/lib/torrserver/torrents:/opt/ts/torrents:Z"
      "/var/lib/torrserver/config:/opt/ts/config:Z"
    ];

    extraOptions = [
      # Врубаем сеть хоста напрямую. Прощай, оверхед сокетов!
      "--network=host"
      "--label=io.containers.autoupdate=registry"
    ];

    environment = {
      TS_DONTKILL = "1";
      TS_HTTPAUTH = "0";
      TS_CONF_PATH = "/opt/ts/config";
      TS_TORR_DIR = "/opt/ts/torrents";
    };
  };

  # Открываем порт в файрволе ОС (так как контейнер слушает порт хоста напрямую)
  networking.firewall.allowedTCPPorts = [ 8090 ];

  systemd.services.podman-torrserver = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
