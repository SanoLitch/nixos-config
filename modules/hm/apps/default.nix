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
    ./firefox.nix
    ./aerc.nix
    ./khal.nix
    ./email-accounts.nix
    ./calendar-accounts.nix
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
    libreoffice
    spotify-player

    # jetbrains.webstorm # able to install only via vpn
  ];
}
