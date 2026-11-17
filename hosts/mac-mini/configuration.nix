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

  # Mac mini doesn't have an internal keyboard on BCE, so apple-bce in initrd is unnecessary
  boot.initrd.kernelModules = lib.mkForce [ ];

  # Remote builder on mini-pc
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "192.168.20.100";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 16;
        speedFactor = 4;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        sshUser = "sano";
        sshKey = "/root/.ssh/id_ed25519";
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  # Automatically trust mini-pc host key so nix-daemon connects without interactive prompts
  programs.ssh.knownHosts."192.168.20.100".publicKey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBViKQ/LRNNhUF8dX8Vw+MVZQ/aEpv5n5aurLa7vm0TB";

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
