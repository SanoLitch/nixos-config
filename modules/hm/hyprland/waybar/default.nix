{ pkgs, lib, ... }:
{
  imports = [ ./resolution-module.nix ];

  xdg.configFile."waybar/modules/custom-clock.jsonc".source = ./custom-clock.jsonc;
  xdg.configFile."waybar/modules/custom-language.jsonc".source = ./custom-language.jsonc;

  xdg.configFile."waybar/layouts/custom.jsonc".source = ./custom-layout.jsonc;

  home.file.".config/waybar/config.jsonc" = lib.mkForce {
    source = ./custom-layout.jsonc;
    force = true;
  };
}
