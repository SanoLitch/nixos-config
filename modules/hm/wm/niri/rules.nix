{ ... }:
{
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [ { namespace = "^noctalia-wallpaper*"; } ];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      {
        draw-border-with-background = false;
        geometry-corner-radius = {
          top-left = 2.0;
          top-right = 2.0;
          bottom-left = 2.0;
          bottom-right = 2.0;
        };
        clip-to-geometry = true;
        opacity = 0.94;
      }
      {
        matches = [ { is-active = true; } ];
        opacity = 0.97;
      }
    ];
  };
}
