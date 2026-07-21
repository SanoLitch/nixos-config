{ pkgs, lib, ... }:
{
  imports = [
    ./boot.nix
    ./nix.nix
    ./locale.nix
    ./drivers.nix
    ./networking.nix
    ./keyd.nix
    ./podman.nix
    ./ssh.nix
    ./steam.nix
    ./clash-verge.nix
    ./zsh.nix
  ];

  environment.variables = {
    EDITOR = "nvim";
    SQL_EDITOR = "nvim";
    VISUAL = "nvim";
    WEATHER_SHOW_LOCATION = "false";
    WEATHER_LOCATION = "moscow";
    BROWSER = "firefox";
    TERM = "kitty";
  };

  environment.systemPackages = with pkgs; [
    gcc
    fd
    openssl
    dnsutils
    appimage-run
  ];
}
