{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    k9s
  ];
  xdg = {
    configFile = {
      "k9s/config.yaml".text = builtins.readFile ./config.yaml;

      "k9s/skins/catppuccin-mocha.yaml".text = builtins.readFile ./skins/catppuccin-mocha.yaml;

      "k9s/plugins/log-view.yaml".text = builtins.readFile ./plugins/log-view.yaml;
    };
  };
}
