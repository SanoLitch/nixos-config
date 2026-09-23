{ ... }:
{
  programs.noctalia.settings.bar.main = {
    background_opacity = 0.5;
    capsule = true;
    capsule_opacity = 0.2;
    capsule_thickness = 0.85;
    capsule_radius = 4;

    start = [
      "cpu"
      "temp"
      "ram"
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
  };
}
