{
  pkgs,
  ...
}:
{
  imports = [
    ./keepassxc.nix
    ./nixvim
    ./gemini.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    btop
    brave
    pcloud
    telegram-desktop
    ripgrep
    devbox
    zoom-us
    lazygit
    ddcutil
    unar
    spotify-player

    # jetbrains.webstorm # able to install only via vpn
  ];
}
