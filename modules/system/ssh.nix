{ lib, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = lib.mkForce false;
  };
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;
}
