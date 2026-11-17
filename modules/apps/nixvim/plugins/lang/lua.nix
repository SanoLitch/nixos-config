{
  plugins = {
    lsp.servers.lua_ls = {
      enable = true;
      settings = {
        Lua = {
          diagnostics = {
            globals = [ "vim" ];
          };
          workspace = {
            checkThirdParty = false;
          };
          telemetry = {
            enable = false;
          };
        };
      };
    };
    lazydev.enable = true;
  };
}
