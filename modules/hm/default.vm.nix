{ ... }:
{
  imports = [
    ./apps
    ./wm
    ./terminal
    ./utils
  ];

  programs.niri.settings = {
    outputs."Virtual-1" = {
      mode = {
        width = 3440;
        height = 1440;
        refresh = 144.0;
      };
      scale = 1.6;
    };
  };

  home.stateVersion = "25.05";
}
