{
  config,
  lib,
  pkgs,
  ...
}:
let
  # cleanJsonCfg = pkgs.runCommand "waybar-config-cleaned.json" { } ''
  #   grep -v '^[[:space:]]*//' ${pkgs.hyde}/Configs/.config/waybar/config.jsonc > $out
  # '';
  # cleanJsonCfg =
  #   pkgs.runCommand "waybar-config-cleaned.json"
  #     {
  #       nativeBuildInputs = [ pkgs.json5 ];
  #     }
  #     ''
  #       json5 -c ${pkgs.hyde}/Configs/.config/waybar/config.jsonc > $out
  #     '';
  cleanJsonCfg =
    pkgs.runCommand "waybar-config-cleaned.json"
      {
        nativeBuildInputs = [ pkgs.python312Packages.json5 ];
      }
      ''
                python -c "                                                                      
        import json5                                                                    
        import json
        import sys

        with open('${pkgs.hyde}/Configs/.config/waybar/config.jsonc', 'r') as f:
          data = json5.load(f)

        json.dump(data, sys.stdout)
                " > $out
      '';
  jsonOriginCfg = builtins.fromJSON (builtins.readFile cleanJsonCfg);
  # aModules = lib.map (
  #   name: if name == "clock" then "custom/clock" else name
  # ) jsonOriginCfg."group/pill-in#center".modules;

  modifiedJsonCfg = jsonOriginCfg // {
    "group/pill-in#center" = {
      # modules = aModules ++ [ "custom/language" ];
      modules = jsonOriginCfg."group/pill-in#center".modules ++ [ "hyprland/language" ];
    };
  };
  finalJsonCfg = builtins.toJSON modifiedJsonCfg;
in
{
  home.file = {
    ".config/waybar/modules/custom-clock.jsonc" = {
      source = ./custom-clock.jsonc;
    };
    ".config/waybar/modules/custom-language.jsonc" = {
      source = ./custom-language.jsonc;
    };
    ".config/waybar/config.jsonc" = lib.mkForce {
      text = finalJsonCfg;
      force = true;
    };
  };
}
