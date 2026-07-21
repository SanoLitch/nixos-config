{ pkgs, secrets, ... }:
{
  programs.nix-ld = {
    enable = true;
  };

  documentation.nixos.enable = false;

  nix = {
    settings = {
      trusted-users = [
        "root"
        "@wheel"
        secrets.user.username
      ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
