{
  config,
  lib,
  pkgs,
  ...
}:
# let
#   cfg = config.hydenix.hm.hyprland;
# in
{
  # home.file = {
  #   ".config/hypr/keybindings.conf" = {
  #     text = ''
  #       ${lib.replaceStrings [ "# $mainMod = Super" ] [ "$mainMod = Alt" ] (
  #         lib.readFile "${pkgs.hyde}/Configs/.config/hypr/keybindings.conf"
  #       )}
  #       ${cfg.keybindings.extraConfig}
  #     '';
  #     force = true;
  #   };
  # };
  #
  # hydenix.hm.hyprland.keybindings.overrideConfig = " \n ";

  hydenix.hm.hyprland.keybindings.extraConfig = ''
    unbind = $mainMod, G
    unbind = $mainMod Shift, G
    unbind = $mainMod Alt, Right
    unbind = $mainMod Alt, Left
    unbind = $mainMod Alt, Up
    unbind = $mainMod Alt, Down
    unbind = $mainMod Shift, R
    unbind = $mainMod Shift, T
    unbind = $mainMod+Shift, Y
    unbind = $mainMod+Shift, U
    unbind = $mainMod Alt, S
    unbind = $mainMod Alt, P
    unbind = $mainMod, Z
    unbind = $mainMod, X
    unbind = Alt_R, Control_R

    unbind = $mainMod, F
    bindd = $mainMod, F, $d toggle fullscreen, fullscreen
    unbind = $mainMod, E
    bind = $mainMod, E, exec, kitty -e yazi

    $d=[$wm|Group Navigation]
    unbind = $mainMod, H
    unbind = $mainMod, L
    bindd = $mainMod Control, H, $d change active group backwards   , changegroupactive, b
    bindd = $mainMod Control, L, $d change active group forwards  , changegroupactive, f

    $d=[$wm|Change focus]
    unbind = $mainMod, H
    unbind = $mainMod, L
    unbind = $mainMod, K
    unbind = $mainMod, J
    bindd = $mainMod, H, $d focus left, movefocus, l
    bindd = $mainMod, L, $d focus right , movefocus, r
    bindd = $mainMod, K, $d focus up , movefocus, u
    bindd = $mainMod, J, $d focus down, movefocus, d


    $d=[$wm|Resize Active Window]
    # Resize windows
    unbind = $mainMod Shift Control, L
    unbind = $mainMod Shift Control, H
    unbind = $mainMod Shift Control, K
    unbind = $mainMod Shift Control, J
    bindde = $mainMod Shift Control, L, $d resize window right , resizeactive, 30 0
    bindde = $mainMod Shift Control, H, $d resize window left, resizeactive, -30 0
    bindde = $mainMod Shift Control, K, $d resize window up, resizeactive, 0 -30
    bindde = $mainMod Shift Control, J, $d resize  window down, resizeactive, 0 30


    # Move active window around current workspace with mainMod + Shift + Control [←→↑↓]
    $d=[$wm|Move active window across workspace]
    unbind = $mainMod Shift Alt, H
    unbind = $mainMod Shift Alt, L
    unbind = $mainMod Shift Alt, K
    unbind = $mainMod Shift Alt, J
    bindde = $mainMod Shift Alt, H, Move active window to the left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l
    bindde = $mainMod Shift Alt, L, Move active window to the right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r
    bindde = $mainMod Shift Alt, K, Move active window up, exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u
    bindde = $mainMod Shift Alt, J, Move active window down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d


    $d=[$ws|Navigation|Relative workspace]
    unbind = $mainMod Shift, L
    unbind = $mainMod Shift, H
    bindd = $mainMod Shift, L, $d change active workspace forwards  , workspace, r+1
    bindd = $mainMod Shift, H, $d change active workspace backwards , workspace, r-1

    bind = $mainMod, mouse:276, workspace, r+1
    bind = $mainMod, mouse:275, workspace, r-1
  '';
}
