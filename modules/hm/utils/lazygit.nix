{ pkgs, ... }:
{

  home.packages = with pkgs; [
    lazygit
    delta
  ];

  home.file.".config/lazygit/config.yml".text = ''
    git:
      pagers:
        - colorArg: always
          pager: delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"
    gui:
      nerdFontsVersion: "3" # Если используешь Nerd Font
  '';
}
