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
        "vault"
      ];
  };

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

  boot.kernelPackages =
    let
      kernelPkgs = inputs.nixpkgs-kernel.legacyPackages.${pkgs.system};
      t2generic = "${inputs.nixos-hardware}/apple/t2/pkgs/linux-t2/generic.nix";
      t2Kernel = (kernelPkgs.callPackage t2generic { } {
        kernel = kernelPkgs.linux_6_18;
        patchesFile = ./patches-6.18.json;
      }).override (old: {
        structuredExtraConfig = (old.structuredExtraConfig or { }) // (with kernelPkgs.lib.kernel; {
          APPLE_BCE = unset;
          T2BCE_CORE = module;
          T2BCE_DMA = module;
          T2BCE_VHCI = module;
          T2BCE_AUDIO = module;
        });
      });
    in
    lib.mkForce (kernelPkgs.linuxPackagesFor t2Kernel);

  # nixos-hardware's apple-t2 module puts "apple-bce" into initrd, but the 6.18
  # patchset renamed the driver to t2bce_*, so it has to be dropped. mkForce wipes
  # every other contribution too, so re-add what the rest of the config needs:
  # btrfs for /nix (needed in stage 1) and dm_mod from the default initrd set.
  # Mac mini has no internal keyboard, so BCE isn't needed this early.
  boot.initrd.kernelModules = lib.mkForce [
    "btrfs"
    "dm_mod"
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
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "ru_RU.UTF-8";
    };
  };
  networking.hostName = hostname;

  host = {
    core = {
      vpn.enable = false;
    };
    hardware = {
      audio.enable = false;
      bluetooth.enable = true;
      graphics.enable = false;
      keyd.enable = false;
      power.enable = false;
    };
    cli = {
      calendar.enable = false;
      email.enable = false;
    };
    apps = {
      antigravity.enable = false;
      claude.enable = false;
      keepassxc.enable = true;
      mpv.enable = false;
      syncthing.enable = false;
      zen.enable = false;
      helium.enable = false;
      steam.enable = false;
      easyeffects.enable = false;
      nixvim.enable = true;
      clash-verge.enable = false;
      zoom.enable = false;
      misc.enable = false;
      rtk.enable = false;
      mempalace.enable = false;
    };
    terminal = {
      fastfetch.enable = false;
      kitty.enable = false;
    };
  };

  system.stateVersion = "26.11";
}
