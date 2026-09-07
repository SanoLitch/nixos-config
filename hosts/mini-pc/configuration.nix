{
  inputs,
  hostname,
  pkgs,
  lib,
  secrets,
  ...
}:
{
  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "zoom"
        "spotify"
        "steam"
        "steam-unwrapped"
        "antigravity-cli"
        "claude-code"
      ];
    permittedInsecurePackages = [
      "pnpm-9.15.9"
    ];
  };

  imports = [
    inputs.home-manager.nixosModules.home-manager

    ../../modules/core
    ../../modules/hardware
    ../../modules/desktop
    ../../modules/terminal
    ../../modules/cli
    ../../modules/apps
    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    extraSpecialArgs = { inherit inputs secrets; };

    users."${secrets.user.username}" =
      { ... }:
      {
        home.stateVersion = "25.05";
      };
  };

  users.users.${secrets.user.username} = {
    isNormalUser = true;
    initialPassword = secrets.user.password;
    extraGroups = secrets.user.groups;
    shell = pkgs.zsh;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = hostname;

  boot.kernelParams = [
    "video=HDMI-A-1:2732x2048@60e"
  ];

  host = {
    apps = {
      sunshine = {
        enable = true;
        outputName = "HDMI-A-1";
      };
    };
    desktop.niri = {
      enable = true;
      outputs = {
        "DP-1" = {
          mode = {
            width = 3440;
            height = 1440;
            refresh = 144.0;
          };
          scale = 1.6;
        };
        "HDMI-A-1" = {
          enable = false;
          mode = {
            width = 2732;
            height = 2048;
            refresh = 60.0;
          };
          scale = 2.0;
          position = {
            x = 3440;
            y = 0;
          };
        };
      };
    };
    hardware = {
      k380.enable = true;
      power.enable = false;
    };
  };

  system.stateVersion = "25.05";
}
