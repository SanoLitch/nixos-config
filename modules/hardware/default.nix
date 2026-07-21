{ lib, ... }:
{
  imports = [
    ./audio
    ./k380
    ./keyd
  ];

  host.hardware.audio.enable = lib.mkDefault true;
  host.hardware.k380.enable = lib.mkDefault false;
  host.hardware.keyd.enable = lib.mkDefault true;
}
