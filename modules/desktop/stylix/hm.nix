{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  home.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  gtk.gtk4.theme = lib.mkForce config.gtk.theme;

  stylix = {
    enable = true;
    overlays.enable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    targets = {
      kitty.variant256Colors = true;
      neovim.enable = false;
      nixvim.enable = false;
      zen-browser = {
        enable = true;
        profileNames = [ "Default User" ];
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      # Основной интерфейс
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      # Документы
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      # Терминал и Код (Caskaydia Cove)
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10;
        terminal = 10;
        popups = 10;
      };
    };
  };
}
