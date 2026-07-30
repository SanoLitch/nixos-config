{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./lazygit.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    btop
    eza
    lazysql
    lazydocker
    unar
    jq
    devbox
    gitui
  ];

  programs.bat = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--iglob=!.git"
    ];
  };
}
