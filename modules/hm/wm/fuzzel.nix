{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepmenu
  ];

  xdg.configFile."keepmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = fuzzel --dmenu

    [database]
    database_1 = ~/Documents/Secrets/pass_db.kdbx
    type_library = wtype
    terminal = kitty
    editor = nvim
    hide_groups = true
    pw_cache_period_min = 1024
    autotype_default = {USERNAME}{TAB}{PASSWORD}{ENTER}
  '';

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        dpi-aware = "no";
        show-actions = "yes";
        width = 50;
        lines = 15;
        horizontal-pad = 20;
        vertical-pad = 10;
        inner-pad = 5;
      };

      key-bindings = {
        prev = "Control+k";
        next = "Control+j";
        cursor-left = "Control+h";
        cursor-right = "Control+l";
        prev-page = "Control+u";
        next-page = "Control+d";
        execute = "Return KP_Enter Control+m";
      };

      border = {
        width = 2;
        radius = 8;
      };
    };
  };
}
