{
  config,
  lib,
  secrets,
  ...
}@args:
let
  cfg = config.host.apps.claude;
in
{
  options.host.apps.claude.enable = lib.mkEnableOption "Claude Code";
  # config = lib.mkIf cfg.enable (
  #   lib.mkMerge [
  #     {
  #       home-manager.users."${secrets.user.username}" = {
  #         imports = [ ./hm.nix ];
  #       };
  #     }
  #     # (import ./system.nix args)
  #   ]
  # );
}
