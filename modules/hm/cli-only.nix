{ ... }:
{
  imports = [
    ./apps/nixvim
    ./apps/syncthing.nix
    ./terminal/starship.nix
    ./utils/bat.nix
    ./utils/git.nix
    ./utils/lazygit.nix
    ./utils/rigrep.nix
    ./utils/yazi.nix
    ./utils/common.nix
  ];

  home.stateVersion = "26.11";
}
