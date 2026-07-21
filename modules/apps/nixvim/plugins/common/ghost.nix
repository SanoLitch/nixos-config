{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nvim-ghost.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "subnut";
        repo = "nvim-ghost.nvim";
        rev = "main"; # Или конкретный хэш, если хочешь зафиксировать
        sha256 = "sha256-TEjRBHAMFplxr5d0lomeVF4yNCVGOoCvKCDy+HXzcxQ=";
      };
    })
  ];

  # Настройка через Lua
  extraConfigLua = ''
    -- Настройки nvim-ghost.nvim
    require("ghost").setup({
      port = 4001,
      logging_level = "info",
    })
  '';
}
