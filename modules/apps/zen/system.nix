{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      firefoxpwa-unwrapped = prev.firefoxpwa-unwrapped.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          mkdir -p $out/lib/firefoxpwa
        '';
      });
    })
  ];
}
