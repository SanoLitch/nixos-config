{ ... }:
{
  programs.zsh = {
    enable = true;

    autosuggestions.enable = true;
    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "vi-mode"
      ];
    };
  };

  system.userActivationScripts.zshrc = "touch .zshrc";
}
