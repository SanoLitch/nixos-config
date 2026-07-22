{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.hardware.networking;
in {
  options.host.hardware.networking.enable = lib.mkEnableOption "Networking tools and settings";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
