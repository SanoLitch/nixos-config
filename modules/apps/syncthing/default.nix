{ config, lib, secrets, ... }:
let cfg = config.host.apps.syncthing;
in {
  options.host.apps.syncthing.enable = lib.mkEnableOption "Syncthing Client";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
