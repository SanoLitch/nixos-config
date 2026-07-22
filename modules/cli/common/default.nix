{ config, lib, secrets, ... }:
let cfg = config.host.cli.common;
in {
  options.host.cli.common.enable = lib.mkEnableOption "Common CLI Utilities";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
