{ pkgs, ... }:
{
  imports = [
    ./nix.nix
    ./drivers.nix
    ./networking.nix
    ./keyboard-layout.nix
    ./keyd.nix
    # ./docker.nix
    ./podman.nix
    ./outline
  ];

  environment.systemPackages = with pkgs; [
    gcc
    openssl
  ];
}
