{
  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        signcolumn = true;
        current_line_blame = true;
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "eol";
        };
        signs = {
          add = {
            text = "┃";
          };
          change = {
            text = "┃";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
          untracked = {
            text = "┆";
          };
        };
        signs_staged = {
          add = {
            text = "┃";
          };
          change = {
            text = "┃";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
          untracked = {
            text = "┆";
          };
        };
        watch_gitdir = {
          follow_files = true;
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>gd";
      action = ":Gitsigns diffthis<CR>";
      options = {
        silent = true;
        desc = "Diff This";
      };
    }
  ];
}
