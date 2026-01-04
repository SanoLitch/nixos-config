{ pkgs, lib, ... }:
{
  imports = [
    ./nix.nix
    ./locale.nix
    ./drivers.nix
    ./networking.nix
    ./keyboard-layout.nix
    ./keyd.nix
    # ./docker.nix
    ./podman.nix
    ./outline
    ./ssh.nix
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    gcc
    fd
    openssl
    appimage-run
  ];
}
