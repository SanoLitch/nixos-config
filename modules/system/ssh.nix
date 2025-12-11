{ lib, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = lib.mkForce false;
  };
  programs.ssh.startAgent = true;
}
