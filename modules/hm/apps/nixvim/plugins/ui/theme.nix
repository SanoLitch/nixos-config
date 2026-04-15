{
  colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        integrations.native_lsp = {
          enabled = true;
          underlines = {
            errors = [ "undercurl" ];
            hints = [ "undercurl" ];
            warnings = [ "undercurl" ];
            information = [ "undercurl" ];
          };
        };
        flavor = "mocha";
        italic = false;
        no_italic = true;
        no_bold = false;
        transparent_background = true;
      };
    };
  };
}
