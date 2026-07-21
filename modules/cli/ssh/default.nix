{ config, lib, secrets, ... }:
let cfg = config.host.cli.ssh;
in {
  options.host.cli.ssh.enable = lib.mkEnableOption "SSH client and server";
  config = lib.mkIf cfg.enable {
    programs.ssh.startAgent = true;
    services.openssh.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = lib.mkForce false;
    };
    services.gnome.gcr-ssh-agent.enable = false;

    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
