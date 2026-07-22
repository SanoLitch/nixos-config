{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.core.locale;
in {
  options.host.core.locale.enable = lib.mkEnableOption "System Locale Configuration";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
