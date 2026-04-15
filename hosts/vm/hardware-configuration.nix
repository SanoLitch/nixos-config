{
  pkgs,
  ...
}:
{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
      diskSize = 40960;
      qemu = {
        options = [
          "-device virtio-vga-gl"
          "-display gtk,gl=on,grab-on-hover=on"

          "-cpu host"
          "-enable-kvm"
          "-machine q35"

          "-usb -device usb-tablet"

          # "-device amd-iommu"
          "-device intel-hda -device hda-duplex"
          "-vga none"
        ];
      };
    };
    services.xserver = {
      videoDrivers = [
        "virtio"
      ];
    };
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    # GDK_SCALE = "0.5";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "0.5";
  };

  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    open-vm-tools
    spice-gtk
    spice-vdagent
    spice
  ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd = {
    enable = true;
  };

}
