{ lib, ... }:
{
  imports = [
    ./audio
    ./k380
    ./keyd
    ./networking
    ./graphics
    ./bluetooth
    ./power
  ];

  host.hardware.audio.enable = lib.mkDefault true;
  host.hardware.k380.enable = lib.mkDefault false;
  host.hardware.keyd.enable = lib.mkDefault true;
  host.hardware.networking.enable = lib.mkDefault true;
  host.hardware.graphics.enable = lib.mkDefault true;
  host.hardware.bluetooth.enable = lib.mkDefault true;
  host.hardware.power.enable = lib.mkDefault true;
}
