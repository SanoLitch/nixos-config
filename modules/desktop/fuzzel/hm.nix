{ pkgs, ... }:
let
  fuzzel-bluetooth = import ./bluetooth.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    keepmenu
    fuzzel-bluetooth
  ];

  xdg.configFile."keepmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = fuzzel --dmenu

    [database]
    database_1 = ~/Sync/Secrets/pass_db.kdbx
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
