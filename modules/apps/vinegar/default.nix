{
  config,
  lib,
  secrets,
  ...
}@args:
let
  cfg = config.host.apps.vinegar;
in
{
  options.host.apps.vinegar.enable = lib.mkEnableOption "Vinegar";
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        home-manager.users."${secrets.user.username}" = {
          imports = [ ./hm.nix ];
        };
      }
      # (import ./system.nix args)
    ]
  );
}
