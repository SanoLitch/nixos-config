{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clash-verge-rev
  ];

  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    serviceMode = true;
    autoStart = true;
  };

  networking.firewall = {
    checkReversePath = false;
  };
}
