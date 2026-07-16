{ inputs, pkgs, ... }:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
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
    # (extension "to-google-translate" "jid1-93WyvpgvxzGATw@jetpack")
    (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
    # (extension "firenvim" "firenvim@lacamb.re")
    # ...
  ];

in
{
  imports = [
    # inputs.zen-browser.homeModules.beta
    # or
    inputs.zen-browser.homeModules.twilight
    # or
    # inputs.zen-browser.homeModules.twilight-official
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    nativeMessagingHosts = [
      pkgs.firefoxpwa
      pkgs.tridactyl-native
    ];
    policies = {
      ExtensionSettings = builtins.listToAttrs extensions;
      SearchEngines = {
        Default = "ddg";
      };
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };

  xdg.configFile."tridactyl/tridactylrc".text = ''
    set editorcmd kitty nvim %f

    unbind <Space>

    " Группа подсказок (Space + f)
    bind <Space>fa hint -Jc a
    bind <Space>fb hint -Jc button
    bind <Space>fi hint -Jc input:not([type="button"]):not([type="submit"]):not([type="checkbox"]):not([type="radio"]):not([type="hidden"]), textarea, [contenteditable="true"], [contenteditable=""], [role="textbox"], [role="searchbox"], [role="combobox"]
    bind <Space>ft hint -Jc [role="tab"], [aria-selected], [aria-controls], [class*="tab" i]
    bind <Space>fm hint -Jc dialog, [role="dialog"], [role="alertdialog"], [aria-modal="true"], [class*="modal" i] button, [class*="modal" i] [aria-label*="close" i]
    bind <Space>fd hint -Jc [aria-haspopup="true"], [aria-expanded], [role="menuitem"], [role="option"], [role="listbox"], [class*="dropdown" i]
    bind <Space>fl hint -Jc [style*="z-index"], [class*="overlay" i], [class*="fixed" i], [class*="sticky" i], [class*="popup" i], [class*="floating" i], [class*="layer" i], [class*="toast" i], [popover]

    " Группа управления вкладками (Space + b)
    bind <Space>bd tabclose
    bind <Space>bo composite tabclosealltoleft ; tabclosealltoright
    bind K tabprev
    bind J tabnext
  '';
}
