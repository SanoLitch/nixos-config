{ lib, ... }:
let
  defaultWallpaper = ../wallpapers/anime-girl-violet.jpg;
in
{
  programs.noctalia.settings = {
    theme = lib.mkForce {
      mode = "dark";
      source = "builtin";
      builtin = "Catppuccin";
    };
    wallpaper = {
      enabled = true;
      default.path = defaultWallpaper;
    };
    backdrop = {
      enabled = true;
    };
  };
}
