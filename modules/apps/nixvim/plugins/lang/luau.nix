{ pkgs, ... }:
{
  plugins = {
    lsp.servers.luau_lsp.enable = true;
  };

  extraPackages = with pkgs; [
    luau
  ];
}
