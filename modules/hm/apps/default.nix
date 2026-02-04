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
    ./zsh.nix
    ./bat.nix
    ./lazygit.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    btop
    brave
    pcloud
    telegram-desktop
    ripgrep
    devbox
    zoom-us
    lazysql
    lazydocker
    wl-clipboard
    ddcutil
    unar
    libreoffice
    rustdesk
    spotify-player

    # jetbrains.webstorm # able to install only via vpn
  ];
}
