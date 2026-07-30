{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    telegram-desktop
    libreoffice
    spotify
    qbittorrent
    wl-clipboard
    ddcutil
    networkmanagerapplet
    wtype
    claude-code
  ];

  xdg = {
    configFile = {
      "autostart/blueman.desktop".text = "[Desktop Entry]\nHidden=true";
    };
  };
}
