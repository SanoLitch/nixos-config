{
  inputs,
  hostname,
  pkgs,
  secrets,
  lib,
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
        "nvidia-x11"
        "nvidia-settings"
        "nvidia-kernel-modules"
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

    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-cpu-intel
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
  host.desktop.niri = {
    enable = true;
    outputs."eDP-1" = {
      scale = 1.2;
    };
  };
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware = {
    graphics.enable = true;
    nvidia = {
      prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
        # sync.enable = true;
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
      open = false;
      modesetting.enable = true;
    };
  };

  system.stateVersion = "25.05";
}
