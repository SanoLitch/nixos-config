{ secrets, ... }: {
  virtualisation.podman.enable = true;

  systemd.tmpfiles.rules = [
    "d /var/lib/forgejo 0755 sano users - -"
  ];

  virtualisation.oci-containers.containers.forgejo = {
    image = "codeberg.org/forgejo/forgejo:16-rootless";

    volumes = [
      "/var/lib/forgejo:/var/lib/gitea:Z"
      "/etc/localtime:/etc/localtime:ro"
    ];

    extraOptions = [
      "--userns=keep-id"
      "--publish=3000:3000"
      "--publish=2222:2222"
    ];

    environment = {
      USER_UID = "1000";
      USER_GID = "1000";
      FORGEJO__server__DOMAIN = secrets.forgejo.domain;
      FORGEJO__server__ROOT_URL = secrets.forgejo.rootUrl;
      FORGEJO__server__SSH_DOMAIN = secrets.forgejo.sshDomain;
      FORGEJO__server__SSH_PORT = "22";
    };
  };

  networking.firewall.allowedTCPPorts = [
    3000
    2222
  ];

  systemd.services.podman-forgejo = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
