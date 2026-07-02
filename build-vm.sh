#!/run/current-system/sw/bin/sh

echo "Temporarily adding 'config' to git index for Nix build..."
cp -R .config config
git add config
trap 'echo "Cleaning up git index..."; git reset config > /dev/null 2>&1; rm -rf config' EXIT

echo "rebuilding system for vm"

sudo nixos-rebuild build-vm --flake .#vm
