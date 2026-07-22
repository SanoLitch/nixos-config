{ config, lib, secrets, ... }:
let cfg = config.host.apps.easyeffects;
in {
  options.host.apps.easyeffects.enable = lib.mkEnableOption "EasyEffects Audio Equalizer";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
