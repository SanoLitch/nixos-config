{ ... }: {

  programs.noctalia.settings.widget = {
    cpu = {
      type = "sysmon";
      stat = "cpu_usage";
    };
    temp = {
      type = "sysmon";
      stat = "cpu_temp";
    };
    ram = {
      type = "sysmon";
      stat = "ram_used";
    };

    clock = {
      type = "clock";
      format = "{:%a} {:%H:%M}, {:%d %b %y}";
    };

    workspaces = {
      show_labels = false;
      style = "focus_hint";
      hide_when_empty = true;
      focused_output_only = true;
    };

    privacy = {
      type = "privacy";
      hide_inactive = true;
      icon_spacing = 6;
      active_color = "primary";
      inactive_color = "on_surface";
    };

    network = {
      show_label = false;
    };

    tray = {
      match_adjacent_spacing = true;
      drawer = true;
      pinned = [ "steam" ];
      hide_passive = false;
    };

    control-center = {
      glyph = "U+F313";
    };
  };
}
