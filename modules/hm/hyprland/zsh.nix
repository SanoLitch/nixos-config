{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pay-respects
  ];

  hydenix.hm.shell.zsh.configText = ''
    alias lzg=lazygit
    alias lzd=lazydocker
    alias lzs=lazysql

    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    alias cat=bat
    alias b=bat

    alias lt='eza --tree --level=2 --icons'
    alias ll='eza -la --icons --group-directories-first --header --git'

    alias ssh="kitty +kitten ssh"

    alias f="$(pay-respects zsh)"
    alias fuck="$(pay-respects zsh)"
    eval "$(pay-respects zsh)"
  '';
}
