{ config, lib, pkgs, ... }@args:
let cfg = config.host.hardware.power;
in {
  options.host.hardware.power.enable = lib.mkEnableOption "Power management";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
