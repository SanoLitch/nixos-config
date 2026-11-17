{ ... }:
{
  programs.noctalia.settings.bar.main = {
    background_opacity = 0.5;
    capsule = true;
    capsule_opacity = 0.2;
    capsule_thickness = 0.85;
    capsule_radius = 4;

    start = [
      "group:sysmon"
      "clock"
      "caffeine"
      "workspaces"
    ];

    center = [ "privacy" ];

    end = [
      "keyboard_layout"
      "network"
      "bluetooth"
      "volume"
      "tray"
      "notifications"
      "clipboard"
      "settings"
    ];

    capsule_group = [
      {
        id = "sysmon";
        members = [
          "cpu"
          "temp"
          "ram"
        ];
        fill = "surface_variant";
        padding = 6.0;
        opacity = 0.2;
        enabled = true;
        accordion = false;
      }
    ];
  };
}
