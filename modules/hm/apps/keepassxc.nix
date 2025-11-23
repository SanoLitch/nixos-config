{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
  ];

  # programs.keepassxc = {
  #   enable = true;
  #   autostart = true;
  #   settings = {
  #     GUI_ShowTrayIcon.Enabled = true;
  #     GUI_MinimizeToTray.Enabled = true;
  #     GUI_MinimizeOnClose.Enabled = true;
  #   };
  # };
  #
  # xdg.autostart.enable = true;
}
