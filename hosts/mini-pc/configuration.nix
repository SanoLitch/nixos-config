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
        "vault"
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
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_GB.UTF-8";
    };
  };
  networking.hostName = hostname;

  boot.kernelParams = [
    "video=HDMI-A-1:2732x2048@60e"
  ];

  systemd.tmpfiles.rules = [
    "w /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference - - - - balance_power"
  ];

  host = {
    apps = {
      clash-verge.enable = false;
      sunshine = {
        enable = true;
        outputName = "HDMI-A-1";
      };
      vinegar.enable = true;
    };
    desktop.niri = {
      enable = true;
      extraConfig = ''
        output "DP-1" {
            scale 1.6
            mode "3440x1440@144.0"
        }

        output "HDMI-A-1" {
            off
            scale 2.0
            position x=3440 y=0
            mode "2732x2048@60.0"
        }
      '';
    };
    hardware = {
      k380.enable = true;
      power.enable = false;
    };
  };

  system.stateVersion = "25.05";
}
