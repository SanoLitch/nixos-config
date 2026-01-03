{ pkgs, ... }:
let
  monitorDesc = "desc:Xiaomi Corporation Mi Monitor";

  resToggle = pkgs.writeShellScriptBin "res-toggle" ''
    CURRENT=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.description | contains("Xiaomi")) | .width')

    if [ "$CURRENT" = "3440" ]; then
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "${monitorDesc}, 2560x1080@144, auto, 1.333334"
        ${pkgs.libnotify}/bin/notify-send "Resolution" "Switched to 2560x1080"
    else
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "${monitorDesc}, 3440x1440@144, auto, 1.6"
        ${pkgs.libnotify}/bin/notify-send "Resolution" "Switched to Default"
    fi
  '';

  resCheck = pkgs.writeShellScript "res-check" ''
    CURRENT=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.description | contains("Xiaomi")) | .width')
    if [ "$CURRENT" = "3440" ]; then
        echo '{"text": "1440p", "tooltip": "Resolution: 3440x1440\nScale: 1.6"}'
    else
        echo '{"text": "1080p", "tooltip": "Resolution: 2560x1080\nScale: 1.6"}'
    fi
  '';

  resolutionModule = {
    "custom/resolution" = {
      format = "  {}";
      exec = "${resCheck}";
      return-type = "json";
      interval = 5;
      on-click = "${resToggle}/bin/res-toggle";
      tooltip = true;
    };
  };
in
{
  xdg.configFile."waybar/modules/resolution.jsonc".text = builtins.toJSON resolutionModule;
}
