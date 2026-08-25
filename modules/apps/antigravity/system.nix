{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      antigravity-cli =
        let
          rawAgy =
            (import inputs.nixpkgs-agy {
              system = "x86_64-linux";
              config.allowUnfreePredicate = pkg: builtins.elem (prev.lib.getName pkg) [ "antigravity-cli" ];
            }).antigravity-cli;
        in
        rawAgy.overrideAttrs (oldAttrs: {
          nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
            final.python3
            final.makeWrapper
          ];
          postInstall = (oldAttrs.postInstall or "") + ''
            python3 ${./patch_antigravity.py} $out/bin/agy
          '';
        });
    })
  ];
}
