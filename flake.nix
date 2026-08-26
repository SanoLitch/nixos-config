{
  description = "Personal NixOS configuration Niri + Noctalia Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-agy.url = "github:nixos/nixpkgs/56c02bc00adcf003215cc4bd996d6efaf4cff188";

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  nixConfig = {
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://niri.cachix.org"
      "https://zen-browser.cachix.org"
      "https://cache.soopy.moe"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "zen-browser.cachix.org-1:z/QLGrEkiBYF/7zoHX1Hpuv0B26QrmbVBSy9yDD2tSs="
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
    ];
  };
  outputs =
    inputs:
    let
      system = "x86_64-linux";

      mkNixosSystem =
        hostname: modules:
        let
          local_config = ./.config;
          secrets = {
            user = builtins.fromJSON (builtins.readFile "${local_config}/common/user.json");
            git = builtins.fromJSON (builtins.readFile "${local_config}/common/git.json");
            vpn = builtins.fromJSON (builtins.readFile "${local_config}/common/vpn.json");
            email = builtins.fromJSON (builtins.readFile "${local_config}/common/email.json");
            sync = builtins.fromJSON (builtins.readFile "${local_config}/common/sync.json");
            mcp = builtins.fromJSON (builtins.readFile "${local_config}/common/mcp.json");
            cloudflared = builtins.fromJSON (builtins.readFile "${local_config}/mac-mini/cloudflared.json");
            forgejo = builtins.fromJSON (builtins.readFile "${local_config}/mac-mini/forgejo.json");
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
        dell = mkNixosSystem "dell" [ ./hosts/dell/configuration.nix ];
        mini-pc = mkNixosSystem "mini-pc" [ ./hosts/mini-pc/configuration.nix ];
        mac-mini = mkNixosSystem "mac-mini" [ ./hosts/mac-mini/configuration.nix ];
      };
    };
}
