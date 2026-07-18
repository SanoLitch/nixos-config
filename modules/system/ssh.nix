{ lib, ... }:
{
  programs.ssh = {
    startAgent = true;
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = lib.mkForce false;
  };
  services.gnome.gcr-ssh-agent.enable = false;
}
