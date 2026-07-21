#!/run/current-system/sw/bin/sh

pkg=${1}

nix why-depends --derivation .#nixosConfigurations.mini-pc.config.system.build.toplevel ".#nixosConfigurations.mini-pc.pkgs.$pkg"
