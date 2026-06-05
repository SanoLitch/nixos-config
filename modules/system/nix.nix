{ pkgs, secrets, ... }:
{
  # Enable nix ld
  programs.nix-ld = {
    enable = true;
  };

  documentation.nixos.enable = false;

  nixpkgs.overlays = [
    (final: prev: {
      firefoxpwa-unwrapped = prev.firefoxpwa-unwrapped.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          mkdir -p $out/lib/firefoxpwa
        '';
      });
    })
  ];

  nix = {
    settings = {
      # Add trusted users
      trusted-users = [
        "root"
        "@wheel"
        secrets.user.username
      ];

      # Enable flakes and new nix command
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Auto optimize store
      auto-optimise-store = true;
    };

    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
