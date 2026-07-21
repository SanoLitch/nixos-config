{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.core.boot;
in {
  options.host.core.boot.enable = lib.mkEnableOption "System Boot Configuration";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
