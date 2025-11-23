{
  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      log_level = "warn";
      notify_on_error = true;
      notify_no_formatters = true;
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      formatters_by_ft = {
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
        html = {
          __unkeyed-1 = "prettierd";
          stop_after_first = true;
        };
        css = {
          __unkeyed-1 = "prettierd";
          stop_after_first = true;
        };
        javascript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "eslint_d";
          stop_after_first = true;
        };
        javascriptreact = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "eslint_d";
          stop_after_first = true;
        };
        typescript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "eslint_d";
          stop_after_first = true;
        };
        typescriptreact = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "eslint_d";
          stop_after_first = true;
        };
        nix = [ "nixfmt" ];
        markdown = {
          __unkeyed-1 = "prettierd";
          stop_after_first = true;
        };
        sh = [ "shfmt" ];
        json = {
          __unkeyed-1 = "prettierd";
          # __unkeyed-2 = "jq";
          stop_after_first = true;
        };
      };
    };

  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua require('conform').format()<cr>";
      options = {
        silent = true;
        desc = "Format Buffer";
      };
    }
  ];
}
