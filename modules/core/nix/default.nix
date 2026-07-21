{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.core.nix;
in {
  options.host.core.nix.enable = lib.mkEnableOption "Nix Package Manager Configuration";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
