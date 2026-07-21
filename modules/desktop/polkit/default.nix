{ config, lib, pkgs, ... }@args:
let cfg = config.host.desktop.polkit;
in {
  options.host.desktop.polkit.enable = lib.mkEnableOption "Polkit Authentication Agent";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
