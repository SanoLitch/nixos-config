{
  inputs,
  hostname,
  pkgs,
  secrets,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix
    ./substituter.nix
    ../../modules/apps
    ../../modules/core
    ../../modules/hardware
    ../../modules/services
    ../../modules/terminal
    ../../modules/cli

    inputs.nixos-hardware.nixosModules.apple-t2
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    extraSpecialArgs = { inherit inputs secrets; };

    users."${secrets.user.username}" =
      { ... }:
      {
        home.stateVersion = "26.11";
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

  host = {
    core = {
      vpn.enable = false;
    };
    hardware = {
      audio.enable = false;
      graphics.enable = false;
      bluetooth.enable = true;
      keyd.enable = false;
      power.enable = false;
    };
    cli = {
      calendar.enable = false;
      email.enable = false;
    };
    apps = {
      antigravity.enable = false;
      keepassxc.enable = true;
      mpv.enable = false;
      syncthing.enable = false;
      zen.enable = false;
      steam.enable = false;
      easyeffects.enable = false;
      nixvim.enable = true;
      clash-verge.enable = false;
      zoom.enable = false;
      misc.enable = false;
    };
    terminal = {
      fastfetch.enable = false;
    };
  };

  system.stateVersion = "26.11";
}
