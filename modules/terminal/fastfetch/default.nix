{ config, lib, secrets, ... }:
let cfg = config.host.terminal.fastfetch;
in {
  options.host.terminal.fastfetch.enable = lib.mkEnableOption "Fastfetch";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
