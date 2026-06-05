{ lib, ... }:
{
  programs.noctalia-shell.settings.bar = {
    density = "default";
    position = "top";
    barType = "simple";
    showCapsule = true;
    capsuleOpacity = lib.mkForce 0.35;
    useSeparateOpacity = true;
    backgroundOpacity = lib.mkForce 0.35;
    widgets = {
      left = [
        {
          id = "SystemMonitor";
          compactMode = false;
        }
        {
          id = "Clock";
          formatHorizontal = "HH:mm, dd MMM yy";
          formatVertical = "HH mm";
          useMonospacedFont = true;
          usePrimaryColor = false;
        }
        {
          id = "KeepAwake";
        }
      ];
      center = [
      ];
      right = [
        {
          id = "MediaMini";
          showVisualizer = true;
          visualizerType = "linear";
          maxWidth = 545;
        }
        {
          id = "KeyboardLayout";
          showIcon = false;
        }
        {
          id = "Tray";
          drawerEnabled = false;
          colorizeIcons = true;
        }
        {
          id = "Battery";
        }
        {
          id = "NotificationHistory";
        }
        {
          id = "Volume";
        }
        {
          id = "ControlCenter";
          useDistroLogo = true;
          icon = "noctalia";
          enableColorization = true;
        }
      ];
    };
  };
}
