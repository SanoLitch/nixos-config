{ config, lib, secrets, ... }:
let cfg = config.host.apps.zen;
in {
  options.host.apps.zen.enable = lib.mkEnableOption "Zen Browser";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
