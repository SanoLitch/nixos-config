{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  defaultWallpaper = ../wallpapers/anime-girl-violet.jpg;
in
{
  imports = [
    inputs.noctalia.homeModules.default

    ./bar.nix
    ./general.nix
    ./idle.nix
    ./sessions.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      inherit defaultWallpaper;
    };
  };

  programs.noctalia-shell = {
    enable = true;

    settings = {
      colorSchemes.predefinedScheme = "Catppuccin";

      ui = {
        panelBackgroundOpacity = lib.mkForce 0.85;
      };

      location = {
        analogClockInCalendar = "true";
        name = "Moscow, RU";
        firstDayOfWeek = 1;
        showWeekNumberInCalendar = true;
      };

      dock.enabled = false;

      notifications = {
        backgroundOpacity = lib.mkForce 0.9;
        respectExpireTimeout = true;
        enableKeyboardLayoutToast = false;
        saveToHistory = {
          low = false;
          normal = false;
          critical = true;
        };
      };

    };
  };
}
