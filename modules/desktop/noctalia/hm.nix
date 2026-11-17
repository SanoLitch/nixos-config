{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default

    ./shell.nix
    ./bar.nix
    ./notifications.nix
    ./widgets.nix
    ./idle.nix
    ./theme.nix
    # ./calendars.nix
  ];

  programs.noctalia = {
    enable = true;
  };
}
