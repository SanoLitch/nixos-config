{
  config,
  lib,
  secrets,
  ...
}:
let
  cfg = config.host.apps.mempalace;
in
{
  options.host.apps.mempalace.enable = lib.mkEnableOption "MemPalace client (hub runs on mac-mini)";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
