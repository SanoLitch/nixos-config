{ config, lib, secrets, ... }:
let cfg = config.host.terminal.starship;
in {
  options.host.terminal.starship.enable = lib.mkEnableOption "Starship Prompt";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
