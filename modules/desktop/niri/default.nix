{ config, lib, pkgs, secrets, ... }:
let
  cfg = config.host.desktop.niri;
in
{
  options.host.desktop.niri = {
    enable = lib.mkEnableOption "Niri Window Manager";
    outputs = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Niri monitor outputs configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    services.gnome.gnome-keyring.enable = false;

    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
      programs.niri.settings.outputs = cfg.outputs;
    };
  };
}
