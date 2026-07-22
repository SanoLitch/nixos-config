{ config, lib, pkgs, ... }@args:
let cfg = config.host.cli.podman;
in {
  options.host.cli.podman.enable = lib.mkEnableOption "Podman container engine";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
