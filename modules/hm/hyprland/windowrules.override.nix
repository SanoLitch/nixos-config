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
  home.file.".config/hypr/windowrules.conf" = lib.mkForce {
    source = ./windowrules.config.conf;
    force = true;
  };

  # 1. Удаляем файл и возможные бэкапы ДО того, как Home Manager начнет проверять конфликты.
  # Это предотвращает ошибку "Existing file ... would be clobbered".
  home.activation.cleanWindowRules = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    run rm -f $HOME/.local/share/hypr/windowrules.conf
    run rm -f $HOME/.local/share/hypr/windowrules.conf.bak
    run rm -f $HOME/.local/share/hypr/windowrules.conf.hm-backup
  '';

  # 2. После того, как hydenix (или HM) запишет свой файл, мы его перезаписываем нашим.
  home.activation.overwriteHydenixWindowRules = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run rm -f $HOME/.local/share/hypr/windowrules.conf
    run cp -f ${./windowrules.local.conf} $HOME/.local/share/hypr/windowrules.conf
    run chmod 644 $HOME/.local/share/hypr/windowrules.conf
  '';
}