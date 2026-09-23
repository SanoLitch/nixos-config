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

  home.packages = with pkgs; [
    satty
    grim
    slurp
    cliphist
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      spawn-at-startup = [
        {
          command = [
            "sh"
            "-c"
            "wl-paste --type text --watch cliphist store"
          ];
        }
        {
          command = [
            "sh"
            "-c"
            "wl-paste --type image --watch cliphist store"
          ];
        }
        {
          command = [
            "noctalia"
          ];
        }
        {
          command = [
            "nm-applet"
          ];
        }
        {
          command = [
            "solaar"
            "-w"
            "hide"
            "--restart-on-wake-up"
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
