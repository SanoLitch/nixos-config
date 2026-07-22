{ pkgs }:

pkgs.writeShellApplication {
  name = "fuzzel-bluetooth";
  runtimeInputs = with pkgs; [ bluez libnotify fuzzel gawk coreutils gnugrep ];
  text = ''
    if ! bluetoothctl show | grep -q "Powered: yes"; then
      bluetoothctl power on
      sleep 1
    fi

    devices=$(bluetoothctl devices)
    if [ -z "$devices" ]; then
      notify-send "Bluetooth" "No devices found"
      exit 0
    fi

    connected=$(bluetoothctl devices Connected | awk '{print $2}')

    options=""
    while read -r line; do
      mac=$(echo "$line" | awk '{print $2}')
      name=$(echo "$line" | cut -d' ' -f3-)
      if echo "$connected" | grep -q "$mac"; then
        status="[Connected]"
      else
        status="[Disconnected]"
      fi
      options="$options$status $name ($mac)\n"
    done <<< "$devices"

    selected=$(echo -e "$options" | fuzzel --dmenu -p "Bluetooth: ")
    [ -z "$selected" ] && exit 0

    mac=$(echo "$selected" | grep -o '([0-9A-Fa-f:]*)' | tr -d '()')

    if echo "$connected" | grep -q "$mac"; then
      bluetoothctl disconnect "$mac"
      notify-send "Bluetooth" "Disconnected $mac"
    else
      bluetoothctl connect "$mac"
      notify-send "Bluetooth" "Connected $mac"
    fi
  '';
}
