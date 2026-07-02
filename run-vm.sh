#!/run/current-system/sw/bin/sh

MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')

hyprctl keyword monitor "$MONITOR, 3440x1440@144, auto, 1.0"
trap 'hyprctl keyword monitor "$MONITOR, 3440x1440@144, auto, 1.6"' EXIT

./result/bin/run-nixos-vm
