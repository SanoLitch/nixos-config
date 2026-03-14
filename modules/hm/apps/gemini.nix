{
  pkgs,
  lib,
  secrets,
  ...
}:
let
  settings = {
    general = {
      preferredEditor = "neovim";
      previewFeatures = true;
      vimMode = false;
      disableAutoUpdate = true;
      sessionRetention = {
        warningAcknowledged = true;
        enabled = true;
        maxAge = "180d";
      };
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
    mcpServers = {
      context7 = {
        httpUrl = "https://mcp.context7.com/mcp";
        headers = {
          CONTEXT7_API_KEY = secrets.apps.context7ApiKey;
          Accept = "application/json, text/event-stream";
        };
      };
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

  home.activation.installGeminiExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH=$PATH:${lib.makeBinPath [ pkgs.git ]}   

    LOG_FILE=$HOME/gemini-install.log

    echo "--- Gemini Install Started: $(date) ---" > "$LOG_FILE"

    install_ext() {
      EXT_NAME=$1
      EXT_URL=$2

      if [ ! -d "$HOME/.gemini/extensions/$EXT_NAME" ]; then
        echo "Installing: $EXT_URL" >> "$LOG_FILE"
        $DRY_RUN_CMD ${pkgs.gemini-cli}/bin/gemini extensions install "$EXT_URL" --auto-update --consent --debug >> "$LOG_FILE" 2>&1 || echo "Failed to install $EXT_NAME" >> "$LOG_FILE"
      else
        echo "Extension $EXT_NAME is already installed, skipping." >> "$LOG_FILE"
      fi

      echo "-----------------------------------" >> "$LOG_FILE"
    }

    install_ext "conductor" "https://github.com/gemini-cli-extensions/conductor"
    install_ext "superpowers" "https://github.com/obra/superpowers"
    # install_ext "context7" "https://github.com/upstash/context7"

    echo "--- Gemini Install Finished: $(date) ---" >> "$LOG_FILE"
  '';
}
