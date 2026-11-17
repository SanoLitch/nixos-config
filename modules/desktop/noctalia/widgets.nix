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
      style = "regular";
      show_labels = false;
      hide_when_empty = true;
      focused_output_only = true;
      pill_scale = 0.5;
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
  };
}
