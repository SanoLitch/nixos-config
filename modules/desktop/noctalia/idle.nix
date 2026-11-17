{ ... }:
{
  programs.noctalia.settings.idle = {
    pre_action_fade_seconds = 10;

    behavior_order = [
      "screen-off"
      "lock"
      "suspend"
    ];

    behaviour = {
      screen-off = {
        timeout = 600;
        action = "screen_off";
      };
      lock = {
        timeout = 600;
        action = "lock";
      };
      suspend = {
        timeout = 600;
        lock_before_suspend = true;
        action = "suspend";
      };
    };
  };
}
