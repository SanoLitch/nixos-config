{ config, lib, pkgs, ... }@args:
let cfg = config.host.hardware.graphics;
in {
  options.host.hardware.graphics.enable = lib.mkEnableOption "Graphics support";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
