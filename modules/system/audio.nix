{ pkgs, ... }:
{
  # Включаем PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # Настройка VBAN приемника
    wireplumber.extraConfig."51-scarlett-auto-profile" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "device.name" = "~alsa_card.usb-Focusrite_Scarlett_2i2_USB.*"; } ];
          actions.update-props = {
            "api.acp.auto-profile" = true;
            "api.acp.auto-port" = true;
          };
        }
      ];
    };

    extraConfig.pipewire."99-vban-receiver" = {
      # "context.properties" = {
      #   "default.clock.rate" = 48000;
      #   "default.clock.quantum" = 1024; # Больший размер блока уменьшает нагрузку и чувствительность к мелким лагам
      # };
      "context.modules" = [
        {
          name = "libpipewire-module-vban-recv";
          args = {
            "vban.ip" = "0.0.0.0";
            "vban.port" = 6980;
            "sess.name" = "Stream1"; # Имя потока из Voicemeeter
            "sess.latency.ms" = 200;
            # "node.description" = "VBAN Receiver";
            # "target.object" = "auto";
          };
        }
      ];
    };
  };

  # Открываем UDP порт для VBAN
  networking.firewall.allowedUDPPorts = [ 6980 ];

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    blueman
    pipewire
    wireplumber
    pavucontrol
    pamixer
    playerctl
  ];
}
