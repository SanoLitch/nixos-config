{ config, lib, secrets, ... }:
let cfg = config.host.desktop.noctalia;
in {
  options.host.desktop.noctalia.enable = lib.mkEnableOption "Noctalia Shell";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
