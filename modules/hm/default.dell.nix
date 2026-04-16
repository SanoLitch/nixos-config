{ ... }:
{
  imports = [
    ./apps
    ./wm
    ./terminal
    ./utils
  ];

  programs.niri.settings = {
    outputs."eDP-1" = {
      mode = {
        width = 1920;
        height = 1200;
        refresh = 60.0;
      };
      scale = 1.2;
    };
  };

  home.stateVersion = "25.05";
}
