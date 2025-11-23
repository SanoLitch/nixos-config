#!/run/current-system/sw/bin/sh

echo "Temporarily adding 'config' to git index for Nix build..."
cp -R .config config
git add config
trap 'echo "Cleaning up git index..."; git reset config > /dev/null 2>&1; rm -rf config' EXIT

hostname=${1:-pc} # Use the first argument as hostname, default to 'pc' if not provided

sudo echo "rebuilding system for $hostname"

sudo nixos-rebuild switch --flake ".#$hostname" # --log-format internal-json -v
