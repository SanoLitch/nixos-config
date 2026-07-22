{ config, lib, secrets, ... }:
let cfg = config.host.apps.misc;
in {
  options.host.apps.misc.enable = lib.mkEnableOption "Misc applications";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
