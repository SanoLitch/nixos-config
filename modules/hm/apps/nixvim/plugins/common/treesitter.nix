{
  plugins = {
    mini-ai.enable = true;
    treesitter = {
      enable = true;
      autoLoad = true;
      highlight = {
        enable = true;
        disable = [
          "latex"
          "markdown"
        ];
      };
      folding.enable = false;
      indent.enable = true;
      settings = {
        auto_install = true;
        incremental_selection.enable = true;
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 4;
        min_window_height = 40;
      };
    };
    # tpope's indent fixes
    sleuth.enable = true;
  };
}
