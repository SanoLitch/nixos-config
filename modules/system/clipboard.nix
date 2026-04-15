{ pkgs, ... }:
{

  systemd.user.services.wl-clip-persist = {
    description = "Persist Wayland clipboard when source app closes";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

}
