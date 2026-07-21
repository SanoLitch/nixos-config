{ config, lib, secrets, ... }:
let cfg = config.host.apps.antigravity;
in {
  options.host.apps.antigravity.enable = lib.mkEnableOption "Antigravity CLI";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
