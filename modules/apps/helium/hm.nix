{ inputs, pkgs, ... }:

{
  imports = [
    inputs.helium-flake.homeModules.default
  ];

  programs.helium = {
    enable = true;
    package = pkgs.helium;

    flags = [
      # "--disable-gpu"
      "--ozone-platform-hint=auto"
    ];

    # 🎯 Политики — Записываются в /etc/chromium/policies/managed/helium-nixos.json
    # Также записываются в /etc/helium/policies/managed/ для будущей совместимости
    policies = {
      "BrowserSignin" = 0;
      "PasswordManagerEnabled" = false;
      "SyncDisabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-US"
        "ru-RU"
      ];
    };
  };
}
