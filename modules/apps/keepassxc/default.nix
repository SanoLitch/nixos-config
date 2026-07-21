{ config, lib, secrets, ... }:
let cfg = config.host.apps.keepassxc;
in {
  options.host.apps.keepassxc.enable = lib.mkEnableOption "KeepassXC";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
