{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.hardware.audio;
in {
  options.host.hardware.audio.enable = lib.mkEnableOption "Pipewire Audio Configuration";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
