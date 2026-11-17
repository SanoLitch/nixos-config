{ config, lib, pkgs, secrets, ... }:
let
  cfg = config.host.desktop.niri;
in
{
  options.host.desktop.niri = {
    enable = lib.mkEnableOption "Niri Window Manager";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Host-specific Niri KDL configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    services.gnome.gnome-keyring.enable = false;

    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
      host.desktop.niri.extraConfig = cfg.extraConfig;
    };
  };
}
