{ lib, ... }:
{
  imports = [
    ./antigravity
    ./keepassxc
    ./mpv
    ./syncthing
    ./zen
    ./steam
    ./easy-effects
    ./nixvim
  ];

  host.apps.antigravity.enable = lib.mkDefault true;
  host.apps.keepassxc.enable = lib.mkDefault true;
  host.apps.mpv.enable = lib.mkDefault true;
  host.apps.syncthing.enable = lib.mkDefault true;
  host.apps.zen.enable = lib.mkDefault true;
  host.apps.steam.enable = lib.mkDefault true;
  host.apps.easyeffects.enable = lib.mkDefault true;
  host.apps.nixvim.enable = lib.mkDefault true;
}
