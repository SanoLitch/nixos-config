{ config, lib, secrets, ... }:
let cfg = config.host.cli.email;
in {
  options.host.cli.email.enable = lib.mkEnableOption "Email Configuration (aerc)";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./aerc.nix ./accounts.nix ];
    };
  };
}
