#!/run/current-system/sw/bin/sh

nix run nixpkgs#git-crypt -- unlock ~/.git-crypt.key
