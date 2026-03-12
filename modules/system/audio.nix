{ pkgs, ... }:
{
  # Включаем PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Настройка VBAN приемника
    extraConfig.pipewire."99-vban-receiver" = {
      "context.modules" = [
        {
          name = "libpipewire-module-vban-recv";
          args = {
            "vban.ip" = "0.0.0.0";
            "vban.port" = 6980;
            "sess.name" = "Stream1"; # Имя потока из Voicemeeter
            # "node.description" = "VBAN Receiver";
            # "target.object" = "auto";
          };
        }
      ];
    };
  };

  # Открываем UDP порт для VBAN
  networking.firewall.allowedUDPPorts = [ 6980 ];
}
