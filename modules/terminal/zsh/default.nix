{ config, lib, secrets, ... }:
let cfg = config.host.terminal.zsh;
in {
  options.host.terminal.zsh.enable = lib.mkEnableOption "Zsh & Oh-My-Zsh";
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [ "HIST_IGNORE_ALL_DUPS" ];
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "z" "vi-mode" ];
      };
    };
    system.userActivationScripts.zshrc = "touch .zshrc";

    home-manager.users."${secrets.user.username}" = {
      imports = [ ./hm.nix ];
    };
  };
}
