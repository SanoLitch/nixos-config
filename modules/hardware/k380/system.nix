{ pkgs, ... }:
{
  hardware.logitech.wireless.enable = true;
  programs.solaar.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      solaar = prev.solaar.overrideAttrs (oldAttrs: {
        postPatch =
          (oldAttrs.postPatch or "")
          + ''
            substituteInPlace lib/hidapi/udev_impl.py \
              --replace-fail \
                'filtered_result = filter_func(int(bid, 16), int(vid, 16), int(pid, 16), hidpp_short or centurion, hidpp_long or centurion)' \
                'filtered_result = filter_func(int(bid, 16), int(vid, 16), int(pid, 16), (hidpp_short or centurion) if hidpp_short is not None else None, (hidpp_long or centurion) if hidpp_long is not None else None)'
          '';
      });
    })
  ];
}
