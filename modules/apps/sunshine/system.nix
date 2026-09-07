{ config, lib, pkgs, secrets, ... }:
let
  cfg = config.host.apps.sunshine;
in
{
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    settings = lib.mkMerge [
      (lib.mkIf (cfg.outputName != "") {
        output_name = cfg.outputName;
      })
    ];

    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Desktop";
          image-path = "desktop.png";
          prep-cmd = lib.optionals (cfg.outputName != "") [
            {
              do = "/run/current-system/sw/bin/niri msg output ${cfg.outputName} on";
              undo = "/run/current-system/sw/bin/niri msg output ${cfg.outputName} off";
            }
          ];
        }
        {
          name = "Steam Big Picture";
          detached = [ "setsid steam steam://open/bigpicture" ];
          prep-cmd = lib.optionals (cfg.outputName != "") [
            {
              do = "/run/current-system/sw/bin/niri msg output ${cfg.outputName} on";
              undo = "setsid steam steam://close/bigpicture && /run/current-system/sw/bin/niri msg output ${cfg.outputName} off";
            }
          ];
          image-path = "steam.png";
        }
      ];
    };
  };

  hardware.uinput.enable = true;

  security.wrappers.sunshine.capabilities = lib.mkForce "cap_sys_admin,cap_sys_nice+p";

  users.users.${secrets.user.username}.extraGroups = [
    "input"
    "uinput"
    "video"
    "render"
  ];

  environment.systemPackages = with pkgs; [
    libva-utils
    mesa-demos
    drm_info
  ];
}
