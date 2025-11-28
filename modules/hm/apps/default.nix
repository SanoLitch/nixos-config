{
  pkgs,
  ...
}:
{
  imports = [
    ./keepassxc.nix
    ./nixvim
    ./gemini.nix
  ];

  home.packages = with pkgs; [
    btop
    brave
    pcloud
    yazi
    telegram-desktop
    ripgrep
    devbox
    zoom-us
    lazygit
    ddcutil

    # jetbrains.webstorm # able to install only via vpn
  ];
}
