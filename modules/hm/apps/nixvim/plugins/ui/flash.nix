{
  plugins.flash = {
    enable = true;
    settings = {
      label.uppercase = false;
      search = {
        exclude = [
          "notify"
          "cmp_menu"
          "noice"
          "flash_prompt"
          {
            __raw = ''
              function(win)
                -- exclude non-focusable windows
                return not vim.api.nvim_win_get_config(win).focusable
              end
            '';
          }
        ];
      };
    };
  };

}
