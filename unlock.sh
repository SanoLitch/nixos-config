#!/run/current-system/sw/bin/sh

# Temp shell
# nix shell nixpkgs#git-crypt
nix run nixpkgs#git-crypt -- unlock ~/.git-crypt.key
