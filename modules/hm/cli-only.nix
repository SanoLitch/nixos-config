{ ... }:
{
  imports = [
    ./apps/nixvim
    ./apps/syncthing.nix
  ];

  home.stateVersion = "26.11";
}
