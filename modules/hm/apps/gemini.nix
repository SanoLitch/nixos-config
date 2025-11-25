{ pkgs, ... }:
let
  settings = {
    general = {
      preferredEditor = "nvim";
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
    experimental.codebaseInvestigatorSettings.maxNumTurns = 30;
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
}
