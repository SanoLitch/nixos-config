{
  plugins.nvim-tree = {
    enable = true;
    settings = {
      disable_netrw = true;
      hijack_cursor = true;
      hijack_unnamed_buffer_when_opening = true;
      update_focused_file.enable = true;
      renderer = {
        highlight_git = true;
        highlight_modified = "name";
        highlight_opened_files = "name";
        special_files = null;
      };
      git = {
        enable = true;
      };
      modified = {
        enable = true;
      };
      view = {
        signcolumn = "yes";
      };
      diagnostics.enable = true;
    };
  };

  keymaps = [
    {
      mode = [
        "n"
      ];
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<cr>";
      options.desc = "Toggle Explorer";
    }
  ];
}
