{
  pkgs,
  ...
}:
{
  imports = [
    ./nixvim
    ./gemini.nix
    ./keepassxc.nix
    ./mpv.nix
    ./zen.nix
  ];
  xdg = {
    configFile = {

      "autostart/blueman.desktop".text = "[Desktop Entry]\nHidden=true";
      "autostart/clash-verge.desktop".text = "[Desktop Entry]\nHidden=true";
      "autostart/pcloud.desktop".text = "[Desktop Entry]\nHidden=true";
    };
  };

  home.packages = with pkgs; [
    brave
    pcloud
    telegram-desktop
    zoom-us
    libreoffice
    spotify
    claude-code
    qbittorrent
  ];
}
