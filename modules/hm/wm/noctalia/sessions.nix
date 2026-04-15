{ ... }:
{
  programs.noctalia-shell.settings.sessionMenu = {
    countdownDuration = 5000;
    largeButtonsStyle = false;
    largeButtonsLayout = "grid";
    powerOptions = [
      {
        action = "lock";
        enabled = true;
        keybind = "1";
      }
      {
        action = "reboot";
        enabled = true;
        keybind = "2";
      }
      {
        action = "shutdown";
        enabled = true;
        keybind = "3";
      }
      {
        action = "logout";
        enabled = true;
        keybind = "4";
      }
      {
        action = "suspend";
        enabled = true;
        keybind = "5";
      }
      {
        action = "hibernate";
        enabled = true;
        keybind = "6";
      }
      {
        action = "rebootToUefi";
        enabled = true;
        keybind = "7";
      }
    ];
  };
}
