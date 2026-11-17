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
      t2generic = "${inputs.nixos-hardware}/apple/t2/pkgs/linux-t2/generic.nix";
      patchset = builtins.fromJSON (
        builtins.readFile "${inputs.nixos-hardware}/apple/t2/pkgs/linux-t2/stable.json"
      );
      # 2008-i915-4-lane-quirk-for-mbp15-1.patch is only for MacBookPro15,1 display and breaks build on kernel >= 6.18.55
      filteredPatches = builtins.filter (
        p: p.name != "2008-i915-4-lane-quirk-for-mbp15-1.patch"
      ) patchset.patches;
      customPatchesFile = pkgs.writeText "stable.json" (
        builtins.toJSON (patchset // { patches = filteredPatches; })
      );
      t2Kernel = pkgs.callPackage t2generic { } {
        kernel = pkgs.linux_6_18;
        patchesFile = customPatchesFile;
      };
    in
    lib.mkForce (pkgs.linuxPackagesFor t2Kernel);

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
