{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  # arcWtfTheme = builtins.fetchGit {
  #   url = "https://github.com/KiKaraage/ArcWTF.git";
  #   ref = "main";
  #   rev = "b87561d5ada2fe8c67fa9250f4fc2ee50568cc63";
  # };

  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    # Check these out at about:config
    # "extensions.autoDisableScopes" = 0;
    # ...
    "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
    "cookiebanners.service.mode" = 2; # Block cookie banners
    "privacy.donottrackheader.enabled" = true;
    "privacy.trackingprotection.emailtracking.enabled" = true;
    "privacy.trackingprotection.enabled" = true;
    "privacy.trackingprotection.fingerprinting.enabled" = true;
    "privacy.trackingprotection.socialtracking.enabled" = true;

    "extensions.pocket.enabled" = false; # Disable Pocket integration
    "media.ffmpeg.vaapi.enabled" = true; # Enable hardware video acceleration
    "browser.aboutConfig.showWarning" = false; # Disable about:config warning
    # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    # "svg.context-properties.content.enabled" = true;
  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "sponsorblock" "sponsorBlocker@ajay.app")
    (extension "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}")
    # (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
    (extension "darkreader" "addon@darkreader.org")
    (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org")
    (extension "to-google-translate" "jid1-93WyvpgvxzGATw@jetpack")
    (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
    (extension "firenvim" "firenvim@lacamb.re")
    # ...
  ];

in
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = prefs;

      # 3. Подключаем userChrome.css через импорт скачанного файла
      # userChrome = ''
      #   @import "${arcWtfTheme}/userChrome.css";
      # '';

      # 4. Подключаем userContent.css (часто нужен для страниц настроек и новой вкладки)
      # userContent = ''
      #   @import "${arcWtfTheme}/userContent.css";
      # '';
    };

    policies = {
      DisableTelemetry = true;
      ExtensionSettings = builtins.listToAttrs extensions;

      SearchEngines = {
        Default = "ddg";
        # Add = [
        #   {
        #     Name = "nixpkgs packages";
        #     URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
        #     IconURL = "https://wiki.nixos.org/favicon.ico";
        #     Alias = "@np";
        #   }
        #   {
        #     Name = "NixOS options";
        #     URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
        #     IconURL = "https://wiki.nixos.org/favicon.ico";
        #     Alias = "@no";
        #   }
        #   {
        #     Name = "NixOS Wiki";
        #     URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
        #     IconURL = "https://wiki.nixos.org/favicon.ico";
        #     Alias = "@nw";
        #   }
        #   {
        #     Name = "noogle";
        #     URLTemplate = "https://noogle.dev/q?term={searchTerms}";
        #     IconURL = "https://noogle.dev/favicon.ico";
        #     Alias = "@ng";
        #   }
        # ];
      };
    };
  };

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" ];
  };
}
