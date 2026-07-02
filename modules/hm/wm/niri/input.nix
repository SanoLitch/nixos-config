{ ... }:
{
  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "us,ru";
          options = "grp:win_space_toggle";
        };
        track-layout = "window";
      };

      touchpad = {
        dwt = true;
        natural-scroll = false;
        scroll-factor = 0.5;
      };

      focus-follows-mouse.enable = false;
    };

    gestures.hot-corners = {
      enable = false;
    };

    binds = {
      # Mod key (Super/Windows key)
      "Mod+T".action.spawn = "kitty";
      "Mod+A".action.spawn = "fuzzel";
      "Mod+B".action.spawn = [
        "zen-twilight"
        "--new-window"
      ];
      "Mod+E".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "sessionMenu"
        "toggle"
      ];

      # Window management
      "Mod+Q".action.close-window = { };
      "Mod+H".action.focus-column-left = { };
      "Mod+L".action.focus-column-right = { };
      "Mod+J".action.focus-window-or-workspace-down = { };
      "Mod+K".action.focus-window-or-workspace-up = { };

      # Move windows
      "Mod+Shift+Left".action.move-column-left = { };
      "Mod+Shift+Right".action.move-column-right = { };
      "Mod+Shift+Up".action.move-column-to-workspace-up = { };
      "Mod+Shift+Down".action.move-column-to-workspace-down = { };
      "Mod+Shift+H".action.move-column-left = { };
      "Mod+Shift+L".action.move-column-right = { };
      "Mod+Shift+J".action.move-window-down-or-to-workspace-down = { };
      "Mod+Shift+K".action.move-window-up-or-to-workspace-up = { };

      # Workspaces
      "Mod+Slash".action.focus-workspace = "scratch";
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+0".action.focus-workspace = 0;

      # Move window to workspace
      "Mod+Shift+Slash".action.move-column-to-workspace = "scratch";
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;
      "Mod+Shift+0".action.move-column-to-workspace = 0;

      # Column width
      "Mod+R".action.switch-preset-column-width = { };
      "Mod+Shift+R".action.reset-window-height = { };
      "Mod+F".action.maximize-column = { };
      "Mod+Shift+F".action.fullscreen-window = { };

      # Advanced Niri Features
      "Mod+C".action.center-column = { };
      "Mod+O".action.toggle-overview = { };
      "Mod+G".action.toggle-column-tabbed-display = { };
      "Mod+W".action.toggle-window-floating = { };
      "Mod+Shift+W".action.switch-focus-between-floating-and-tiling = { };

      # Window resizing
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Column merging (Consume/Expel) with ,/.
      "Mod+Comma".action.consume-or-expel-window-left = { };
      "Mod+Period".action.consume-or-expel-window-right = { };

      # Screenshots
      "Mod+P".action.spawn = [
        "sh"
        "-c"
        "grim -g \"$(slurp)\" - | satty --copy-command=\"wl-copy\" --early-exit -f -"
      ];
      "Mod+Shift+P".action.spawn = [
        "sh"
        "-c"
        "grim - | satty --copy-command=\"wl-copy\" --early-exit -f -"
      ];

      # Clipboard history
      "Mod+V".action.spawn = [
        "sh"
        "-c"
        "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
      ];

      "Mod+S".action.spawn = "keepmenu";
      "Mod+Shift+S".action.spawn = [
        "keepmenu"
        "-t"
      ];
      "Mod+N".action.spawn = [
        "sh"
        "-c"
        "nmcli -t -f name,type connection show | grep vpn | cut -d: -f1 | fuzzel --dmenu | xargs -r nmcli connection up"
      ];

      # Volume/Brightness keys
      "XF86AudioRaiseVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1+"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1-"
      ];
      "XF86AudioMute".action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];
      "XF86AudioMicMute".action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SOURCE@"
        "toggle"
      ];
      "XF86MonBrightnessUp".action.spawn = [
        "brightnessctl"
        "set"
        "5%+"
      ];
      "XF86MonBrightnessDown".action.spawn = [
        "brightnessctl"
        "set"
        "5%-"
      ];

      # Mouse/Touchpad binds
      "Mod+WheelScrollDown".action.focus-column-right = { };
      "Mod+WheelScrollUp".action.focus-column-left = { };
      "Mod+MouseForward".action.focus-column-right = { };
      "Mod+MouseBack".action.focus-column-left = { };
      "Mod+TouchpadScrollDown".action.focus-column-right = { };
      "Mod+TouchpadScrollUp".action.focus-column-left = { };
    };

  };
}
