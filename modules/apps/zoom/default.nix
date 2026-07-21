{ config, lib, secrets, ... }:
let cfg = config.host.apps.zoom;
in {
  options.host.apps.zoom.enable = lib.mkEnableOption "Zoom Video Conferencing";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
