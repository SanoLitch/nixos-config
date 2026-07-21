{ lib, ... }:
{
  imports = [
    ./niri
    ./fuzzel
    ./stylix
    ./noctalia
    ./greetd
    ./polkit
  ];

  host.desktop.niri.enable = lib.mkDefault true;
  host.desktop.fuzzel.enable = lib.mkDefault true;
  host.desktop.stylix.enable = lib.mkDefault true;
  host.desktop.noctalia.enable = lib.mkDefault true;
  host.desktop.greetd.enable = lib.mkDefault true;
  host.desktop.polkit.enable = lib.mkDefault true;
}
