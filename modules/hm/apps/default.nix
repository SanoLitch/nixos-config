{
  pkgs,
  ...
}:
{
  imports = [
    ./keepassxc.nix
    ./nixvim
  ];

  home.packages = with pkgs; [
    btop
    brave
    pcloud
    yazi
    gemini-cli
    telegram-desktop
    ripgrep
    devbox
    zoom-us
  ];
}
