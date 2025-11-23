{ pkgs, lib, ... }:
let
  hyprland-per-window-layout = pkgs.rustPlatform.buildRustPackage {
    pname = "hyprland-per-window-layout";
    version = "2.17.0";

    src = pkgs.fetchFromGitHub {
      owner = "coffebar";
      repo = "hyprland-per-window-layout";
      rev = "2.17";
      sha256 = "sha256-wn1xFLi7CYb9A8fR0MaGYrOeIYuF8PCxbGcyQx33H6Y=";
    };

    cargoHash = "sha256-67ewLuhAVaZbUuAwWDZE51dS4T3EkWfYxS40IbvupiM=";

    meta = with lib; {
      description = "Automatic keyboard layout switching for Hyprland - each window remembers its own keyboard layout.";
      homepage = "https://github.com/coffebar/hyprland-per-window-layout";
      license = licenses.asl20;
    };
  };
in
{
  environment.systemPackages = [
    hyprland-per-window-layout
  ];
}
