{ config, lib, pkgs, ... }@args:
let cfg = config.host.apps.clash-verge;
in {
  options.host.apps.clash-verge.enable = lib.mkEnableOption "Clash Verge Proxy";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
