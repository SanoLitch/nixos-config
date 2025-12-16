{ pkgs, lib, ... }:
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
    ./ssh.nix
  ];

  environment.systemPackages = with pkgs; [
    gcc
    fd
    openssl
  ];
}
