#!/run/current-system/sw/bin/sh

hostname=${1:-mini-pc} # Use the first argument as hostname, default to 'pc' if not provided

sudo echo "rebuilding system for $hostname"

nix flake check
