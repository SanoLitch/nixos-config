{ pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };

  powerManagement.resumeCommands = ''
    ${pkgs.systemd}/bin/systemctl restart bluetooth
    ${pkgs.coreutils}/bin/sleep 2
    ${pkgs.bluez}/bin/bluetoothctl power on
  '';

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
