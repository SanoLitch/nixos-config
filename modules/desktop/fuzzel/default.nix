{ config, lib, secrets, ... }:
let cfg = config.host.desktop.fuzzel;
in {
  options.host.desktop.fuzzel.enable = lib.mkEnableOption "Fuzzel";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
