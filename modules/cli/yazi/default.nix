{ config, lib, secrets, ... }:
let cfg = config.host.cli.yazi;
in {
  options.host.cli.yazi.enable = lib.mkEnableOption "Yazi file manager";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
