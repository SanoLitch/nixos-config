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

  host.cli.ssh.enable = lib.mkDefault true;
  host.cli.common.enable = lib.mkDefault true;
  host.cli.email.enable = lib.mkDefault true;
  host.cli.calendar.enable = lib.mkDefault true;
  host.cli.k9s.enable = lib.mkDefault true;
  host.cli.podman.enable = lib.mkDefault true;
}
