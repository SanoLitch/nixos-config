{ pkgs, lib, config, ... }:
let
  # Define settings here so we can generate the file manually
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
  };

  # Generate the INI file in the Nix store
  iniFormat = pkgs.formats.ini { };
  configFile = iniFormat.generate "keepassxc.ini" keepassxcSettings;
in
{
  programs.keepassxc = {
    enable = true;
    package = pkgs.keepassxc;
    # We do NOT set 'settings' here to avoid the read-only symlink
  };

  # Script to copy the config and make it writable
  home.activation.configureKeePassXC = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p "${config.xdg.configHome}/keepassxc"
    run rm -f "${config.xdg.configHome}/keepassxc/keepassxc.ini"
    run cp -f "${configFile}" "${config.xdg.configHome}/keepassxc/keepassxc.ini"
    run chmod u+w "${config.xdg.configHome}/keepassxc/keepassxc.ini"
  '';
}
