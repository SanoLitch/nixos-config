{
  inputs,
  hostname,
  pkgs,
  secrets,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    inputs.home-manager.nixosModules.home-manager

    ../../modules/system # Your custom system modules
    ../../modules/system/default.nix # Your custom system modules
    ./hardware-configuration.nix # Auto-generated hardware config
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
        imports = [
          ../../modules/hm/default.vm.nix
        ];
      };
  };

  # User Account Setup - REQUIRED: Change "hydenix" to your desired username (must match above)
  users.users.${secrets.user.username} = {
    isNormalUser = true;
    initialPassword = secrets.user.password; # SECURITY: Change this password after first login with `passwd`
    extraGroups = secrets.user.groups;
    shell = pkgs.zsh; # Default shell (options: pkgs.bash, pkgs.zsh, pkgs.fish)
  };
  hardware.graphics.enable = true;

  # System Version - Don't change unless you know what you're doing (helps with system upgrades and compatibility)
  system.stateVersion = "25.05";
}
