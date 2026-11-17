{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.helium-flake.overlays.default ];

  environment.systemPackages = [ pkgs.helium ];
}
