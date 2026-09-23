{ ... }:
{
  programs.noctalia.settings.osd = {
    kinds = {
      keyboard_layout = false;
    };
  };

  programs.noctalia.settings.shell = {
    date_format = "%A, %d %B %Y";
    font_family = "Inter";
    corner_radius_scale = 0.5;
    button_borders = false;
    input_borders = false;
    popup_borders = false;
    card_borders = false;

    panel = {
      clipboard_placement = "attached";
      open_near_click_clipboard = true;
      polkit_placement = "attached";
      transparency_mode = "glass";
    };

    session = {
      actions = [
        {
          action = "lock";
          countdown_seconds = 5;
          shortcut = "1";
        }
        {
          action = "reboot";
          countdown_seconds = 5;
          shortcut = "2";
        }
        {
          action = "shutdown";
          countdown_seconds = 5;
          shortcut = "3";
          variant = "destructive";
        }
        {
          action = "logout";
          countdown_seconds = 5;
          shortcut = "4";
        }
        {
          action = "lock_and_suspend";
          countdown_seconds = 5;
          shortcut = "5";
        }
      ];
    };
  };
}
