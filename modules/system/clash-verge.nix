{
  pkgs,
  secrets,
  ...
}:
{
  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    autoStart = true;
  };
}
