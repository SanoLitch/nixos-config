{ lib, ... }:
{
  imports = [
    ./ssh
  ];

  host.cli.ssh.enable = lib.mkDefault true;
}
