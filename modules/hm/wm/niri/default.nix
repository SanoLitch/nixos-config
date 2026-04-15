{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri

    ./input.nix
    ./layout.nix
    ./rules.nix
  ];

  programs.niri = {
    enable = true;
    settings = {
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
          ];
        }
        {
          command = [
            "nm-applet"
          ];
        }
      ];

      animations = {
        slowdown = 0.8;
      };

      cursor = {
        hide-after-inactive-ms = 5000;
        hide-when-typing = true;
      };

      overview = {
        workspace-shadow.enable = false;
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite;
      };
    };
  };
}
