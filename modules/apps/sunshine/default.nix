{ config, lib, pkgs, secrets, ... }@args:
let
  cfg = config.host.apps.sunshine;
in
{
  options.host.apps.sunshine = {
    enable = lib.mkEnableOption "Sunshine Remote Desktop Streaming";
    outputName = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Output name to stream and manage via Sunshine";
    };
  };

  config = lib.mkIf cfg.enable (import ./system.nix args);
}
