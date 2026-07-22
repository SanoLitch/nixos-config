{ config, lib, secrets, ... }:
let cfg = config.host.desktop.stylix;
in {
  options.host.desktop.stylix.enable = lib.mkEnableOption "Stylix Theme Engine";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
