{ ... }:
{
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [ { namespace = "^noctalia-wallpaper*"; } ];
        place-within-backdrop = true;
      }
      # {
      #   matches = [ { namespace = "^noctalia-(background|launcher-overlay|dock)-.*$"; } ];
      #   background-effect = {
      #     xray = false;
      #   };
      # }
    ];

    window-rules = [
      {
        matches = [
          { app-id = "nm-openconnect-auth-dialog"; }
        ];
        open-floating = true;
      }
      {
        matches = [
          { app-id = "nm-openconnect-auth-dialog"; }
        ];
        min-width = 800;
        min-height = 600;
        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "top";
        };
        open-focused = true;
      }
      {
        matches = [
          { app-id = "r#\"^Zoom.*$\"# "; }
        ];
        open-floating = true;
      }
      {
        matches = [
          {
            app-id = "r#\"^Zoom.*$\"# ";
            title = "r#\"^(menu window)$\"#";
          }
        ];
        default-column-width = {
          fixed = 300;
        };
        default-window-height = {
          fixed = 201;
        };
      }
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
        # background-effect = {
        #   blur = true;
        #   xray = false;
        # };
      }
      {
        matches = [ { is-active = true; } ];
        opacity = 0.97;
      }
    ];
  };
}
