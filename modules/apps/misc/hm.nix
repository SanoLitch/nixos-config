{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    telegram-desktop
    libreoffice
    spotify
    qbittorrent
  ];

  xdg = {
    configFile = {
      "autostart/blueman.desktop".text = "[Desktop Entry]\nHidden=true";
    };
  };
}
