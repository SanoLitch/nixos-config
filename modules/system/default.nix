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
    appimage-run
  ];
}
