{ lib, ... }:
{
  plugins.obsidian = {
    enable = true;
    settings = {
      picker = {
        name = "telescope.nvim";
      };
      new_notes_location = "current_dir";
      legacy_commands = false;
      workspaces = [
        {
          name = "default";
          path = lib.nixvim.mkRaw ''
            "~/Documents/Obsidian/default";
          '';
        }
      ];
    };
  };
}
