{
  config,
  lib,
  pkgs,
  secrets,
  ...
}@args:
let
  cfg = config.host.apps.helium;
in
{
  options.host.apps.helium.enable = lib.mkEnableOption "Helium Browser";
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        home-manager.users."${secrets.user.username}" = {
          imports = [ ./hm.nix ];
        };
      }
      (import ./system.nix args)
    ]
  );
}
