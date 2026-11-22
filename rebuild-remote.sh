#!/run/current-system/sw/bin/sh

nixos-rebuild switch --flake .#mac-mini --target-host sano@192.168.20.10 --use-remote-sudo --ask-elevate-password
