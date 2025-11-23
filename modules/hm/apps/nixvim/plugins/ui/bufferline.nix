{
  plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        diagnostics = "nvim_lsp";
        always_show_bufferline = true;
        offsets = [
          {
            filetype = "snacks_layout_box";
            separator = true;
          }
          {
            filetype = "Tree";
            text = "󰙅  File Explorer";
            separator = true;
          }
        ];
      };
    };
  };
}
