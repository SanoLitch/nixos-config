{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.core.networking;
in {
  options.host.core.networking.enable = lib.mkEnableOption "System Networking Configuration";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
