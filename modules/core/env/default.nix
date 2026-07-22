{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.core.env;
in {
  options.host.core.env.enable = lib.mkEnableOption "System Environment Variables and Core Packages";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
