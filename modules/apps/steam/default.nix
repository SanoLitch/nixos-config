{ config, lib, pkgs, ... }@args:
let cfg = config.host.apps.steam;
in {
  options.host.apps.steam.enable = lib.mkEnableOption "Steam Gaming Platform";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
