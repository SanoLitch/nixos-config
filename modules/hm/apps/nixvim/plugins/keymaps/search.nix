{

  plugins.telescope.keymaps = {

    "<leader><space>" = {
      action = "find_files";
      options.desc = "Find project files";
    };
    "<leader>fg" = {
      action = "live_grep";
      options.desc = "Grep (root dir)";
    };
    "<leader>/" = {
      action = "live_grep";
      options.desc = "Grep (root dir)";
    };
    "<leader>ff" = {
      action = "find_files";
      options.desc = "Find project files";
    };
    "<leader>fr" = {
      action = "oldfiles";
      options.desc = "Recent";
    };
    "<leader>ss" = {
      action = "aerial";
      options.desc = "LSP symbols";
    };
    "<leader>st" = {
      action = "todo-comments";
      options.desc = "Todo (Telescope)";
    };
  };
}
