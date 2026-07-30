{
  config,
  lib,
  secrets,
  ...
}@args:
let
  cfg = config.host.apps.antigravity;
in
{
  options.host.apps.antigravity.enable = lib.mkEnableOption "Antigravity CLI";
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
