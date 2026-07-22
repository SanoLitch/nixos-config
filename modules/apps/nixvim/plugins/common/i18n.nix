{ pkgs, ... }:
let
  i18n-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "i18n.nvim";
    version = "2025-02-14";
    src = pkgs.fetchFromGitHub {
      owner = "yelog";
      repo = "i18n.nvim";
      rev = "128959499a9425bb4f1a5574fd92a23be00cb442";
      hash = "sha256-wRqo9iBFDiuz4Mrg7729F5fPeySp+uo3It9fQ/cetbo=";
    };
    dependencies = [ pkgs.vimPlugins.plenary-nvim ];

    # Skip modules that fail the require check because their dependencies
    # (like blink-cmp or fzf-lua) aren't present during the plugin's build phase.
    # They will still work at runtime when Neovim is fully configured.
    nvimSkipModule = [
      "i18n.integration.fzf"
      "i18n.integration.blink_source"
    ];
  };
in
{
  extraPlugins = [ i18n-nvim ];

  extraConfigLua = ''
    require('i18n').setup({
      -- locales: table, key is locale name, value is path to locale file
      -- path can be a string or a function that returns a string
      -- default: {}
      -- locales = {
      --   en = "locales/en.json",
      --   zh = "locales/zh-CN.json",
      -- },
    })
  '';

  plugins.blink-cmp.settings.sources = {
    providers = {
      i18n = {
        name = "i18n";
        module = "i18n.integration.blink_source";
        score_offset = 100;
      };
    };
    default = [
      "lsp"
      "path"
      "snippets"
      "buffer"
      "i18n"
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ia";
      action = "<cmd>lua require('i18n').add()<cr>";
      options = {
        desc = "i18n Add Key";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>is";
      action = "<cmd>lua require('i18n').show()<cr>";
      options = {
        desc = "i18n Show Value";
        silent = true;
      };
    }
  ];
}