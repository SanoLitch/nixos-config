{ config, lib, secrets, ... }:
let cfg = config.host.terminal.kitty;
in {
  options.host.terminal.kitty.enable = lib.mkEnableOption "Kitty Terminal";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
