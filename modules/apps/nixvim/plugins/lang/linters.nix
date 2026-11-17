{ pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      javascript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      nix = [ "statix" ];
      # json = [ "json5" ];
      # markdown = [ "vale" ];
      # text = [ "vale" ];
      bash = [ "shellcheck" ];
      lua = [ "selene" ];
      luau = [ "selene" ];
    };
  };

  extraPackages = with pkgs; [
    shellcheck
    statix
    # nodePackages.json5
    vale
    selene
    stylua
  ];
}
