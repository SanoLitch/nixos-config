{
  description = "template for hydenix";

  inputs = {
    # Your nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Hydenix
    hydenix = {
      # Available inputs:
      # Main: github:richen604/hydenix
      # Commit: github:richen604/hydenix/<commit-hash>
      # Version: github:richen604/hydenix/v1.0.0 - note the version may not be compatible with this template
      url = "github:richen604/hydenix";

      # uncomment the below if you know what you're doing, hydenix updates nixos-unstable every week or so
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware Configuration's, used in ./configuration.nix. Feel free to remove if unused
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    { ... }@inputs:
    let
      system = "x86_64-linux";

      mkNixosSystem =
        hostname: modules:
        let
          local_config = ./config;
          secrets = {
            user = builtins.fromJSON (builtins.readFile "${local_config}/common/user.json");
            git = builtins.fromJSON (builtins.readFile "${local_config}/common/git.json");
            vpn = builtins.fromJSON (builtins.readFile "${local_config}/common/vpn.json");
            outline = builtins.readFile "${local_config}/${hostname}/outline.key";
          };
        in
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs hostname secrets;
          };
          inherit modules;
        };
    in
    {
      nixosConfigurations = {
        pc = mkNixosSystem "pc" [ ./hosts/pc/configuration.nix ];
        dell = mkNixosSystem "dell" [ ./hosts/dell/configuration.nix ];
        mini-pc = mkNixosSystem "mini-pc" [ ./hosts/mini-pc/configuration.nix ];
      };
    };
}
