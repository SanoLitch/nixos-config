{ ... }:
{
  hydenix.hm.hyprland.extraConfig = ''
    input {
      kb_layout = us,ru
      kb_options = grp:win_space_toggle

      touchpad {
        natural_scroll = false
        scroll_factor = 0.3
        disable_while_typing = true
      }
    }

    gesture = 4, horizontal, workspace

    gestures {
      workspace_swipe_distance = 300
      workspace_swipe_min_speed_to_force = 10
      workspace_swipe_invert = false
    }

    cursor {
      inactive_timeout = 3
      hide_on_key_press = true
    }

    general {
      gaps_in = 1
      gaps_out = 1
    }

    decoration {
      rounding = 5
    }

    group {
      # col.border_active = rgba(ca9ee6ff) rgba(f2d5cfff) 45deg
      col.border_inactive = rgba(00000000) rgba(00000000) 45deg
      col.border_locked_inactive = rgba(00000000) rgba(00000000) 45deg
      # col.border_locked_active = rgba(ca9ee6ff) rgba(f2d5cfff) 45deg
      # col.border_locked_inactive = rgba(b4befecc) rgba(6c7086cc) 45deg
    }


    exec-once = pcloud
    exec-once = hyprland-per-window-layout
  '';
}
