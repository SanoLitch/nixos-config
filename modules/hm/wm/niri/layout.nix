{ ... }:
{
  programs.niri.settings = {
    layout = {
      gaps = 4;
      background-color = "transparent";
      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];
      default-column-width = {
        proportion = 0.5;
      };
      border = {
        enable = false;
      };
      focus-ring = {
        enable = false;
        width = 1;
        active = {
          color = "#C0FFEE";
        };
      };
      shadow = {
        enable = true;
        softness = 30;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
        color = "#0007";
      };
    };
  };
}
