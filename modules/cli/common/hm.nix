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
