{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.core.vpn;
in {
  options.host.core.vpn.enable = lib.mkEnableOption "VPN Configuration";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
