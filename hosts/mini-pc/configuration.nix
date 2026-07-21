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
      ];
    permittedInsecurePackages = [
      "pnpm-9.15.9"
    ];
  };

  imports = [
    inputs.home-manager.nixosModules.home-manager

    ../../modules/system # Your custom system modules
    ../../modules/desktop
    ../../modules/terminal
    ../../modules/cli
    ../../modules/apps
    ../../modules/system/audio.nix
    ../../modules/system/k380.nix
    ../../modules/system/vpn.nix
    ./hardware-configuration.nix # Auto-generated hardware config

    # Hardware Configuration - Uncomment lines that match your hardware
    # Run `lshw -short` or `lspci` to identify your hardware

    # GPU Configuration (choose one):
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia # NVIDIA
    inputs.nixos-hardware.nixosModules.common-gpu-amd # AMD

    # CPU Configuration (choose one):
    inputs.nixos-hardware.nixosModules.common-cpu-amd # AMD CPUs
    # inputs.nixos-hardware.nixosModules.common-cpu-intel # Intel CPUs

    # Additional Hardware Modules - Uncomment based on your system type:
    inputs.nixos-hardware.nixosModules.common-hidpi # High-DPI displays
    # inputs.nixos-hardware.nixosModules.common-pc-laptop # Laptops
    inputs.nixos-hardware.nixosModules.common-pc-ssd # SSD storage
  ];

  # Home Manager Configuration - manages user-specific configurations (dotfiles, themes, etc.)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    extraSpecialArgs = { inherit inputs secrets; };
    # User Configuration - REQUIRED: Change "hydenix" to your actual username
    # This must match the username you define in users.users below
    users."${secrets.user.username}" =
      { ... }:
      {
        home.stateVersion = "25.05";
      };
  };

  # User Account Setup - REQUIRED: Change "hydenix" to your desired username (must match above)
  users.users.${secrets.user.username} = {
    isNormalUser = true;
    initialPassword = secrets.user.password; # SECURITY: Change this password after first login with `passwd`
    extraGroups = secrets.user.groups;
    shell = pkgs.zsh; # Default shell (options: pkgs.bash, pkgs.zsh, pkgs.fish)
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = hostname;
  host.desktop.niri = {
    enable = true;
    outputs."DP-1" = {
      mode = {
        width = 3440;
        height = 1440;
        refresh = 144.0;
      };
      scale = 1.6;
    };
  };

  hardware.graphics.enable = true;

  # System Version - Don't change unless you know what you're doing (helps with system upgrades and compatibility)
  system.stateVersion = "25.05";
}
