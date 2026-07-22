{ config, lib, pkgs, ... }@args:
let cfg = config.host.hardware.bluetooth;
in {
  options.host.hardware.bluetooth.enable = lib.mkEnableOption "Bluetooth support";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
