{
  pkgs,
  helpers,
  ...
}:
{
  plugins = {
    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.wl-clipboard;
    };

    image = {
      enable = helpers.enableExceptInTests;
      settings = {
        integrations.markdown = {
          clearInInsertMode = true;
          onlyRenderImageAtCursor = true;
        };
      };
    };

    markdown-preview = {
      enable = true;
    };

    lsp.servers = {
      marksman.enable = true;

      ltex = {
        enable = true;
        filetypes = [
          "markdown"
          "text"
        ];

        settings.completionEnabled = true;

        extraOptions = {
          checkFrequency = "save";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
  ];
}
