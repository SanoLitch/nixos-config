{ ... }:
{
  plugins.obsidian = {
    enable = true;
    settings = {
      picker = {
        name = "telescope.nvim";
      };
      new_notes_location = "current_dir";
      workspaces = [
        {
          name = "default";
          path = "~/Documents/Obsidian/default";
        }
      ];
    };
  };
}
