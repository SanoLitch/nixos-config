#!/run/current-system/sw/bin/sh

hostname=${1:-pc} # Use the first argument as hostname, default to 'pc' if not provided

sudo echo "rebuilding system for $hostname"

sudo nixos-rebuild switch --flake ".#$hostname" # --log-format internal-json -v
