{ lib, ... }:
{
  imports = [
    ./boot
    ./nix
    ./locale
    ./vpn
    ./env
  ];

  host.core.boot.enable = lib.mkDefault true;
  host.core.nix.enable = lib.mkDefault true;
  host.core.locale.enable = lib.mkDefault true;
  host.core.vpn.enable = lib.mkDefault true;
  host.core.env.enable = lib.mkDefault true;
}
