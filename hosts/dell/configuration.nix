{
  inputs,
  local_config,
  hostname,
  pkgs,
  ...
}:
let
  secrets = {
    user = builtins.fromJSON (builtins.readFile "${local_config}/common/user.json");
    git = builtins.fromJSON (builtins.readFile "${local_config}/common/git.json");
    vpn = builtins.fromJSON (builtins.readFile "${local_config}/common/vpn.json");
    outline = builtins.readFile "${local_config}/${hostname}/outline.key";
  };
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.hydenix.overlays.default
  ];

  imports = [
    # hydenix inputs - Required modules, don't modify unless you know what you're doing
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    inputs.hydenix.nixosModules.default
    ../../modules/system # Your custom system modules
    ./hardware-configuration.nix # Auto-generated hardware config

    # Hardware Configuration - Uncomment lines that match your hardware
    # Run `lshw -short` or `lspci` to identify your hardware

    # GPU Configuration (choose one):
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia # NVIDIA
    # inputs.nixos-hardware.nixosModules.common-gpu-amd # AMD

    # CPU Configuration (choose one):
    # inputs.nixos-hardware.nixosModules.common-cpu-amd # AMD CPUs
    inputs.nixos-hardware.nixosModules.common-cpu-intel # Intel CPUs

    # Additional Hardware Modules - Uncomment based on your system type:
    inputs.nixos-hardware.nixosModules.common-hidpi # High-DPI displays
    # inputs.nixos-hardware.nixosModules.common-pc-laptop # Laptops
    inputs.nixos-hardware.nixosModules.common-pc-ssd # SSD storage
  ];

  # If enabling NVIDIA, you will be prompted to configure hardware.nvidia
  hardware.nvidia = {
    open = false; # For newer cards, you may want open drivers
    modesetting.enable = true;
    powerManagement.enable = true;
    prime = {
      # For hybrid graphics (laptops), configure PRIME:
      #     amdBusId = "PCI:0:2:0"; # Run `lspci | grep VGA` to get correct bus IDs
      #     intelBusId = "PCI:0:2:0"; # if you have intel graphics
      #     nvidiaBusId = "PCI:1:0:0";
      offload.enable = false; # Or disable PRIME offloading if you don't care
    };
  };

  # Home Manager Configuration - manages user-specific configurations (dotfiles, themes, etc.)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit inputs secrets; };
    # User Configuration - REQUIRED: Change "hydenix" to your actual username
    # This must match the username you define in users.users below
    users."${secrets.user.username}" =
      { ... }:
      {
        imports = [
          inputs.hydenix.homeModules.default
          ../../modules/hm # Your custom home-manager modules (configure hydenix.hm here!)
          ../../modules/hm/dell.nix
        ];
      };
  };

  users.users.${secrets.user.username} = {
    isNormalUser = true;
    initialPassword = secrets.user.password; # SECURITY: Change this password after first login with `passwd`
    extraGroups = secrets.user.groups;
    shell = pkgs.zsh; # Default shell (options: pkgs.bash, pkgs.zsh, pkgs.fish)
  };

  # Hydenix Configuration - Main configuration for the Hydenix desktop environment
  hydenix = {
    enable = true; # Enable Hydenix modules
    # Basic System Settings (REQUIRED):
    hostname = "dell-laptop"; # REQUIRED: Set your computer's network name (change to something unique)
    timezone = "Europe/Moscow"; # REQUIRED: Set timezone (examples: "America/New_York", "Europe/London", "Asia/Tokyo")
    locale = "en_US.UTF-8"; # REQUIRED: Set locale/language (examples: "en_US.UTF-8", "en_GB.UTF-8", "de_DE.UTF-8")
    # For more configuration options, see: ./docs/options.md
  };

  # System Version - Don't change unless you know what you're doing (helps with system upgrades and compatibility)
  system.stateVersion = "25.05";
}
