{
  config,
  lib,
  secrets,
  ...
}:
let
  cfg = config.host.apps.rtk;
in
{
  options.host.apps.rtk.enable = lib.mkEnableOption "RTK";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
