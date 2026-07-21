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
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>lt";
      action = ":set ft=typescript<CR>";
      options.desc = "Typescript";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>lm";
      action = ":set ft=markdown<CR>";
      options.desc = "Markdown";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>lj";
      action = ":set ft=json<CR>";
      options.desc = "JSON";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>ly";
      action = ":set ft=yaml<CR>";
      options.desc = "YAML";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>lT";
      action = ":set ft=toml<CR>";
      options.desc = "TOML";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>lb";
      action = ":set ft=sh<CR>";
      options.desc = "Bash";
    }
  ];
}
