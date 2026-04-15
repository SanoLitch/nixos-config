{ inputs, pkgs, config, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.niri.homeModules.stylix
  ];

  gtk.gtk4.theme = config.gtk.theme;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    targets = {
      niri.enable = true;
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
      # Основной интерфейс (Cantarell)
      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell Regular";
      };

      # Документы (тот же Cantarell)
      serif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell Regular";
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
