{
  secrets,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    cloudflared
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        ControlMaster auto
        ControlPath ~/.ssh/sockets/%r@%h-%p
        ControlPersist 10m

      Match host "${secrets.git.personal.ssh_host}"
          ProxyCommand ${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h
          StrictHostKeyChecking no
    '';
  };
}
