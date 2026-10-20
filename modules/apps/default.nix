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
    ./clash-verge
    ./zoom
    ./misc
    ./sunshine
    ./helium
  ];

  host = {
    apps = {
      antigravity.enable = lib.mkDefault true;
      keepassxc.enable = lib.mkDefault true;
      mpv.enable = lib.mkDefault true;
      syncthing.enable = lib.mkDefault true;
      zen.enable = lib.mkDefault true;
      helium.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      easyeffects.enable = lib.mkDefault true;
      nixvim.enable = lib.mkDefault true;
      clash-verge.enable = lib.mkDefault true;
      zoom.enable = lib.mkDefault true;
      misc.enable = lib.mkDefault true;
      sunshine.enable = lib.mkDefault false;
    };
  };
}
