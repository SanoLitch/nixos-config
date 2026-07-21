{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.core.drivers;
in {
  options.host.core.drivers.enable = lib.mkEnableOption "Hardware Drivers Configuration";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
