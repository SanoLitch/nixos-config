{
  plugins.scrollview = {
    enable = true;
    settings = {
      base = "right";
      current_only = true;
      diagnostics_severities = [
        {
          __raw = "vim.diagnostic.severity.ERROR";
        }
      ];
      excluded_filetypes = [
        "NvimTree"
      ];
      signs_on_startup = [
        "all"
      ];
    };
  };
}
