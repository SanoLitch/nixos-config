{ pkgs, ... }:
{
  imports = [
    ./aerc.nix
    ./bat.nix
    ./calendar-accounts.nix
    ./email-accounts.nix
    ./git.nix
    ./khal.nix
    ./lazygit.nix
    ./rigrep.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    btop
    eza
    devbox
    lazysql
    lazydocker
    wl-clipboard
    ddcutil
    unar
    networkmanagerapplet
    libfaketime
  ];
}
