{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hydenix.hm.hyprland;
in
{
  home.file = {
    ".config/hypr/windowrules.conf" = {
      text = ''
                ${lib.replaceStrings
                  [ "windowrule = float,initialtitle:^(Open File)" ]
                  [ "windowrule = float, initialTitle:^(Open File)" ]
                  (lib.readFile "${pkgs.hyde}/Configs/.config/hypr/windowrules.conf")
                }
        	${cfg.windowrules.extraConfig}
      '';
      force = true;
    };
  };

  hydenix.hm.hyprland.windowrules = {
    enable = true;
    extraConfig = ''
      	    windowrulev2 = float,center,size 800 600,class:^(org.keepassxc.KeePassXC)$
      	  '';
    overrideConfig = " \n ";
  };
}
