{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Catppuccin Mocha";
        hyperlinks = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };
}
