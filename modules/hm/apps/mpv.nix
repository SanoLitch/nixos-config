{ pkgs, lib, ... }:
let
  shadersPkgs = pkgs.mpv-shim-default-shaders;
  shadersSrc = "${shadersPkgs}/share/mpv-shim-default-shaders/shaders";
in
{
  home.packages = with pkgs; [
    ff2mpv
    # mpv-handler
    xdg-utils
    # yt-dlp
  ];

  # 1. Конфиг для mpv-handler
  # Он лежит в ~/.config/mpv-handler/config.toml
  # xdg.configFile."mpv-handler/config.toml".text = ''
  #   # Путь к плееру (обычно просто mpv достаточно)
  #   mpv_binary = "${pkgs.mpv}/bin/mpv"
  #
  #   # Качество видео (best / 2160p / 1080p / 720p)
  #   quality = "best"
  #
  #   # Опции запуска MPV (например, запуск в фуллскрин)
  #   # flag = ["--fs"]
  # '';
  #
  # # 2. Регистрация MIME-типа (ассоциация mpv:// с приложением)
  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "x-scheme-handler/mpv" = [ "mpv-handler.desktop" ];
  #     # На всякий случай регистрируем и для ytdl протокола, если вдруг встретится
  #     "x-scheme-handler/ytdl" = [ "mpv-handler.desktop" ];
  #   };
  # };

  xdg.configFile."mpv/shaders".source = shadersSrc;

  xdg.configFile."mpv/scripts/history.lua".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/SimpleHistory.lua";
    sha256 = "08055mpsdpw41qcfx8zahnav215pls5w8s9az6vv9ssm73fgdfhw";
  };

  programs.mpv = {
    enable = true;
    scripts = [
      pkgs.mpvScripts.uosc
      pkgs.mpvScripts.thumbfast
    ];

    config = {
      save-position-on-quit = "yes";
      profile = "gpu-hq";
      gpu-api = "vulkan";
      vo = "gpu";
      hwdec = "auto-safe";

      glsl-shaders = "~~/shaders/KrigBilateral.glsl";

      osc = "no";
      osd-bar = "no";
      border = "no";

      af = "dynaudnorm";
    };

    bindings = {
      "Space" = "cycle pause";

      "CTRL+1" =
        "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode A (HQ)\"";

      "CTRL+2" =
        "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode B (Denoise)\"";

      "CTRL+3" =
        "no-osd change-list glsl-shaders set \"~~/shaders/FSRCNNX_x2_16-0-4-1.glsl\"; show-text \"Cinema: FSRCNNX High\"";

      "CTRL+4" =
        "no-osd change-list glsl-shaders set \"~~/shaders/FSR.glsl\"; show-text \"Cinema: AMD FSR\"";

      "CTRL+0" =
        "no-osd change-list glsl-shaders set \"~~/shaders/KrigBilateral.glsl\"; show-text \"Shaders: Reset\"";
    };
  };
}
