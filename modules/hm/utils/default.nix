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
    ./easy-effects
    ./k9s
  ];

  home.packages = with pkgs; [
    btop
    eza
    devbox
    lazysql
    lazydocker
    k9s
    wl-clipboard
    ddcutil
    unar
    networkmanagerapplet
    libfaketime
    jq
    wtype
  ];
}
