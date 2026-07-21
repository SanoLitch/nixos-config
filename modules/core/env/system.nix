{ pkgs, ... }:
{
  environment.variables = {
    EDITOR = "nvim";
    SQL_EDITOR = "nvim";
    VISUAL = "nvim";
    WEATHER_SHOW_LOCATION = "false";
    WEATHER_LOCATION = "moscow";
    BROWSER = "firefox";
    TERM = "kitty";
  };

  environment.systemPackages = with pkgs; [
    gcc
    git
    fd
    openssl
    dnsutils
    appimage-run
  ];
}
