{ config, lib, secrets, ... }:
let cfg = config.host.apps.nixvim;
in {
  options.host.apps.nixvim.enable = lib.mkEnableOption "NixVim Editor";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
