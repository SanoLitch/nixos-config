{
  pkgs,
  ...
}:
{
  imports = [
    ./antigravity.nix
    ./nixvim
    ./keepassxc.nix
    ./mpv.nix
    ./zen.nix
    ./syncthing.nix
  ];
  xdg = {
    configFile = {
      "autostart/blueman.desktop".text = "[Desktop Entry]\nHidden=true";
      "autostart/clash-verge.desktop".text = "[Desktop Entry]\nHidden=true";
    };
  };

  home.packages = with pkgs; [
    brave
    telegram-desktop
    zoom-us
    libreoffice
    spotify
    qbittorrent
  ];
}
