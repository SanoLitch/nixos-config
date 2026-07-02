#!/run/current-system/sw/bin/sh

echo "Temporarily adding 'config' to git index for Nix build..."
cp -R .config config
git add config
trap 'echo "Cleaning up git index..."; git reset config > /dev/null 2>&1; rm -rf config' EXIT

pkg=${1}

nix why-depends --derivation .#nixosConfigurations.mini-pc.config.system.build.toplevel ".#nixosConfigurations.mini-pc.pkgs.$pkg"
