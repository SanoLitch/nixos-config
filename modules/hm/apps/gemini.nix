{ pkgs, lib, ... }:
let
  settings = {
    general = {
      preferredEditor = "neovim";
      previewFeatures = true;
      vimMode = false;
      disableAutoUpdate = true;
    };
    ui = {
      showLineNumbers = false;
      footer = {
        hideContextPercentage = false;
      };
    };
    security = {
      auth = {
        selectedType = "oauth-personal";
      };
    };
    experimental = {
      codebaseInvestigatorSettings.maxNumTurns = 30;
      plan = true;
    };
  };
in
{
  home.packages = with pkgs; [
    gemini-cli
  ];

  home.file = {
    ".gemini/settings.json" = {
      text = builtins.toJSON settings;
      force = true;
      mutable = true;
    };
  };

  home.activation.installGeminiConductor = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.gemini-cli}/bin/gemini extension install https://github.com/gemini-cli-extensions/conductor --auto-update --consent || true
  '';
}
