{ pkgs, ... }:
{
  services.easyeffects = {
    enable = true;
  };

  home.packages = with pkgs; [
    easyeffects
    lsp-plugins
    deepfilternet
  ];
}
