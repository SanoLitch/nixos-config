{
  plugins = {
    mini-ai.enable = true;
    treesitter = {
      enable = true;
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "<Enter>"; # Нажал Enter — выделил слово
          nodeIncremental = "<Enter>"; # Нажал еще раз — выделил строку/выражение
          nodeDecremental = "<BS>"; # Backspace — уменьшить выделение
          scopeIncremental = "<TAB>"; # Выделить всю область видимости (функцию)
        };
      };
      settings = {
        highlight = {
          enable = true;
          disable = [
            "latex"
            "markdown"
          ];
        };
        auto_install = true;
        indent_enable = true;
        folding = true;
        autoLoad = true;
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
