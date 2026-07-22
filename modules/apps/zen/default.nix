{ config, lib, secrets, ... }@args:
let cfg = config.host.apps.zen;
in {
  options.host.apps.zen.enable = lib.mkEnableOption "Zen Browser";
  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home-manager.users."${secrets.user.username}" = {
        imports = [ ./hm.nix ];
      };
    }
    (import ./system.nix args)
  ]);
}
