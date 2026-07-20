{ lib, ... }:
{
  programs.ssh = {
    startAgent = true;
  };
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = lib.mkForce false;
  };
  services.gnome.gcr-ssh-agent.enable = false;
}
