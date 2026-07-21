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
    ./common.nix
  ];

  home.packages = with pkgs; [
    devbox
    k9s
    wl-clipboard
    ddcutil
    networkmanagerapplet
    libfaketime
    wtype
  ];
}
