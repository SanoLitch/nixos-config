{ config, lib, secrets, ... }:
let cfg = config.host.apps.mpv;
in {
  options.host.apps.mpv.enable = lib.mkEnableOption "MPV Video Player";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
