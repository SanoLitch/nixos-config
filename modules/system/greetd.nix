{ pkgs, secrets, ... }:
{
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = secrets.user.username;
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = secrets.user.username;
      };
    };
  };
}
