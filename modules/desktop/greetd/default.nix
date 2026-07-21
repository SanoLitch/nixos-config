{ config, lib, pkgs, secrets, ... }@args:
let cfg = config.host.desktop.greetd;
in {
  options.host.desktop.greetd.enable = lib.mkEnableOption "Greetd Login Manager";
  config = lib.mkIf cfg.enable (import ./system.nix args);
}
