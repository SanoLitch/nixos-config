{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.host.desktop.niri;

  cursor = config.stylix.cursor or {
    name = "Bibata-Modern-Ice";
    size = 24;
  };
in
{
  options.host.desktop.niri = {
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Host-specific Niri KDL configuration";
    };
  };

  config = {
    home.packages = with pkgs; [
      satty
      grim
      slurp
      cliphist
      xwayland-satellite
    ];

    xdg.configFile."niri/config.kdl".source = pkgs.writeTextFile {
      name = "niri-config.kdl";
      text = ''
        ${cfg.extraConfig}

        cursor {
            xcursor-theme "${cursor.name}"
            xcursor-size ${toString cursor.size}
            hide-when-typing
            hide-after-inactive-ms 5000
        }

        xwayland-satellite { path "${lib.getExe pkgs.xwayland-satellite}"; }

        ${builtins.readFile ./kdl/input.kdl}
        ${builtins.readFile ./kdl/layout.kdl}
        ${builtins.readFile ./kdl/binds.kdl}
        ${builtins.readFile ./kdl/rules.kdl}
        ${builtins.readFile ./kdl/startup.kdl}
      '';
      checkPhase = "${lib.getExe pkgs.niri} validate --config \"$target\"";
    };
  };
}
