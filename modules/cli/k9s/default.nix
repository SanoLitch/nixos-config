{ config, lib, secrets, ... }:
let cfg = config.host.cli.k9s;
in {
  options.host.cli.k9s.enable = lib.mkEnableOption "K9s Kubernetes CLI";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
