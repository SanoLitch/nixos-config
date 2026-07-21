{ config, lib, secrets, ... }:
let cfg = config.host.cli.calendar;
in {
  options.host.cli.calendar.enable = lib.mkEnableOption "Calendar Configuration (khal)";
  config = lib.mkIf cfg.enable {
    home-manager.users."${secrets.user.username}" = {
      imports = [ ./khal.nix ./accounts.nix ];
    };
  };
}
