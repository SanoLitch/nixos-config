{
  plugins.yazi.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>uy";
      action = "<cmd>Yazi<cr>";
      options = {
        desc = "Yazi toggle";
        silent = true;
      };
    }
  ];
}
