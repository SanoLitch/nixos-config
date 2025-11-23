{ pkgs, secrets, ... }:
{
  imports = [
    ./editors.nix
    ./windowrules.override.nix
    ./keybindings.override.nix
    ./userprefs.nix
    ./kitty.nix
    # ./waybar
  ];

  hydenix = {
    hm = {
      enable = true;
      dolphin.enable = false;
      firefox.enable = false;
      git = {
        enable = true;
        name = secrets.git.name;
        email = secrets.git.email;
      };
      social = {
        enable = true;
        discord.enable = true;
        vesktop.enable = false;
      };
      theme = {
        enable = true;
        active = "Catppuccin Mocha";
        themes = [
          "Catppuccin Mocha"
          "Tokyo Night"
        ];
      };
    };
  };
}
