{
  keymaps = [

    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = "<cmd>lua require('flash').jump()<cr>";
      options.desc = "Flash";
    }
  ];

  plugins.telescope.keymaps = {
    "gd" = {
      action = "lsp_definitions";
      options.desc = "Go to definition";
    };
    "gr" = {
      action = "lsp_references";
      options.desc = "Go to references";
    };
    "gD" = {
      action = "lsp_type_definitions";
      options.desc = "Go to type definitions";
    };
    "gI" = {
      action = "lsp_implementations";
      options.desc = "Go to implementations";
    };
  };
}
