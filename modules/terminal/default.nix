{ lib, ... }:
{
  imports = [
    ./zsh
    ./kitty
    ./starship
    ./fastfetch
  ];

  host.terminal.zsh.enable = lib.mkDefault true;
  host.terminal.kitty.enable = lib.mkDefault true;
  host.terminal.starship.enable = lib.mkDefault true;
  host.terminal.fastfetch.enable = lib.mkDefault true;
}
