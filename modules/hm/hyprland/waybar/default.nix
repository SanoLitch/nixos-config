{ pkgs, lib, ... }:
{
  xdg.configFile."waybar/modules/custom-clock.jsonc".source = ./custom-clock.jsonc;
  xdg.configFile."waybar/modules/custom-language.jsonc".source = ./custom-language.jsonc;
  xdg.configFile."waybar/modules/custom-khal.jsonc".source = ./custom-khal.jsonc;
  xdg.configFile."waybar/modules/custom-weather.jsonc".source = ./custom-weather.jsonc;

  xdg.configFile."waybar/scripts/khal-waybar.sh" = {
    source = ./khal-waybar.sh;
    executable = true;
  };

  xdg.configFile."waybar/layouts/custom.jsonc".source = ./custom-layout.jsonc;

  home.file.".config/waybar/config.jsonc" = lib.mkForce {
    source = ./custom-layout.jsonc;
    force = true;
  };
}
