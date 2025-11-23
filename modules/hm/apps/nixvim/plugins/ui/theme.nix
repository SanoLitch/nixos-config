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
        bold = true;
        dimInactive = false;
        transparent_background = true;
      };
    };
  };
}
