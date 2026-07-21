{ lib, ... }:
{
  imports = [
    ./zsh
  ];

  host.terminal.zsh.enable = lib.mkDefault true;
}
