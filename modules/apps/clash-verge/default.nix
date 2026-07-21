{
  config,
  lib,
  pkgs,
  secrets,
  ...
}@args:
let
  cfg = config.host.apps.clash-verge;
in
{
  options.host.apps.clash-verge.enable = lib.mkEnableOption "Clash Verge Proxy";
  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home-manager.users."${secrets.user.username}" = {
        imports = [ ./hm.nix ];
      };
    }
    (import ./system.nix args)
  ]);
}
