{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.hardware.keyd;
in {
  options.host.hardware.keyd.enable = lib.mkEnableOption "Keyd keyboard remapper";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
