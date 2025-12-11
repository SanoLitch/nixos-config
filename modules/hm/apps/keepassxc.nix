{
  pkgs,
  lib,
  config,
  ...
}:
let
  keepassxcSettings = {
    General = {
      HideWindowOnCopy = true;
    };
    Browser = {
      AlwaysAllowAccess = true;
      AllowLocalhostWithPasskeys = true;
      Enabled = true;
    };
    GUI = {
      MinimizeOnClose = true;
      MinimizeToTray = true;
      ShowTrayIcon = true;
      TrayIconAppearance = "monochrome-light";
    };
    Security = {
      ClearClipboard = false;
      EnableCopyOnDoubleClick = true;
      LockDatabaseIdle = false;
      LockDatabaseScreenLock = false;
    };
    FdoSecrets = {
      Enabled = true;
    };
    SSHAgent = {
      Enabled = true;
    };
  };

  iniFormat = pkgs.formats.ini { };
  configFile = iniFormat.generate "keepassxc.ini" keepassxcSettings;
in
{
  programs.keepassxc = {
    enable = true;
    package = pkgs.keepassxc;
  };

  home.activation.configureKeePassXC = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "${config.xdg.configHome}/keepassxc"
    run rm -f "${config.xdg.configHome}/keepassxc/keepassxc.ini"
    run cp -f "${configFile}" "${config.xdg.configHome}/keepassxc/keepassxc.ini"
    run chmod u+w "${config.xdg.configHome}/keepassxc/keepassxc.ini"
  '';
}
