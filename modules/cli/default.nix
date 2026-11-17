{ lib, ... }:
{
  imports = [
    ./ssh
    ./common
    ./email
    ./calendar
    ./k9s
    ./podman
  ];
  host = {
    cli = {
      ssh.enable = lib.mkDefault true;
      common.enable = lib.mkDefault true;
      email.enable = lib.mkDefault false;
      calendar.enable = lib.mkDefault false;
      k9s.enable = lib.mkDefault true;
      podman.enable = lib.mkDefault true;
    };
  };
}
