{ pkgs, lib, ... }:
{
  imports = [
    ./boot.nix
    ./nix.nix
    ./locale.nix
    ./podman.nix
    ./networking.nix
  ];

  environment.variables = {
    EDITOR = "nvim";
    SQL_EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.systemPackages = with pkgs; [
    gcc
    fd
    openssl
    dnsutils
  ];
}
