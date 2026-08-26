{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pay-respects
  ];

  programs.pay-respects.enable = true;

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      eval "$(direnv hook zsh)"
      eval "$(pay-respects zsh)"
    '';

    shellAliases = {
      lzg = "lazygit";
      lzd = "lazydocker";
      lzs = "lazysql";

      cat = "bat";
      b = "bat";
      n = "nvim .";

      lt = "eza --tree --level=2 --icons";
      ll = "eza -la --icons --group-directories-first --header --git";

      ".." = "cd ..";
      "..." = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";
      c = "clear";
      mkdir = "mkdir -p";

      ssh = "kitty +kitten ssh";

      f = "$(pay-respects zsh)";
      fuck = "$(pay-respects zsh)";

      tarz = "tar -cvzf";
      tarx = "tar -xvzf";
      tart = "tar -tvzf";
    };
  };
}
