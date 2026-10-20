{ pkgs, inputs, ... }: {
  imports = [
    ./git.nix
    ./lazygit.nix
    ./yazi.nix
    # ./superfile.nix
  ];

  home.packages = with pkgs; [
    btop
    eza
    harlequin
    lazydocker
    unar
    jq
    devbox
    devenv
    direnv
    inputs.superfile.packages.${system}.default
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
