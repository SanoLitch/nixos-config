{ ... }: {
  virtualisation.podman.enable = true;

  systemd.tmpfiles.rules = [
    "d /var/lib/jackett           0755 sano users - -"
    "d /var/lib/jackett/config    0755 sano users - -"
    "d /var/lib/jackett/downloads 0755 sano users - -"
  ];

  virtualisation.oci-containers.containers.jackett = {
    image = "docker.io/linuxserver/jackett:latest";

    volumes = [
      "/var/lib/jackett/config:/config:Z"
      "/var/lib/jackett/downloads:/downloads:Z"
    ];

    extraOptions = [
      # Сажаем Jackett на сеть хоста
      "--network=host"
      "--memory=768m"
      "--label=io.containers.autoupdate=registry"
    ];

    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = "Europe/Moscow";
      AUTO_UPDATE = "true";
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts."jackett.local" = {
      locations."/" = {
        # Стучимся на локалхост, так как Jackett теперь делит сеть с системой
        proxyPass = "http://127.0.0.1:9117";

        extraConfig = ''
          add_header 'Access-Control-Allow-Origin' '*' always;
          add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, DELETE' always;
          add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,Authorization' always;

          if ($request_method = 'OPTIONS') {
             add_header 'Access-Control-Allow-Origin' '*' always;
             add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, DELETE' always;
             add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,Authorization' always;
             add_header 'Access-Control-Max-Age' 1728000;
             add_header 'Content-Type' 'text/plain; charset=utf-8';
             add_header 'Content-Length' 0;
             return 204;
          }
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
    9117
  ];

  systemd.services.podman-jackett = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
