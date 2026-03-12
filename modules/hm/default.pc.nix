{ ... }:
{
  imports = [
    ./hyprland
    ./apps
    ./hyprland/waybarresolution-module.nix
  ];

  hydenix = {
    hm = {
      hyprland = {
        nvidia.enable = true;
        monitors = {
          enable = true;
          overrideConfig = "monitor = desc:Xiaomi Corporation Mi Monitor, 3440x1440@144, auto, 1.6";
        };
      };
    };
  };
}
