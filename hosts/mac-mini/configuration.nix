{
  inputs,
  hostname,
  pkgs,
  secrets,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix # Auto-generated hardware config
    ./substituter.nix
    ../../modules/system/server.nix # Your custom system modules
    ../../modules/services
    ../../modules/terminal
    ../../modules/cli

    inputs.nixos-hardware.nixosModules.apple-t2
    inputs.home-manager.nixosModules.home-manager
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
          ../../modules/hm/cli-only.nix
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

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = hostname;

  # System Version - Don't change unless you know what you're doing (helps with system upgrades and compatibility)
  system.stateVersion = "26.11";
}
