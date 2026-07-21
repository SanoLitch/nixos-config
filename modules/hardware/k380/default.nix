{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.hardware.k380;
in {
  options.host.hardware.k380.enable = lib.mkEnableOption "K380 Keyboard Tweaks";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
