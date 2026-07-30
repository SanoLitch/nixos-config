{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      antigravity-cli =
        (import inputs.nixpkgs-agy {
          system = "x86_64-linux";
          config.allowUnfreePredicate = pkg: builtins.elem (prev.lib.getName pkg) [ "antigravity-cli" ];
        }).antigravity-cli;
    })
  ];
}
