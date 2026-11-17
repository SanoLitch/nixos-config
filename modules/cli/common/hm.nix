{ pkgs, inputs, ... }: {
  imports = [
    ./git.nix
    ./lazygit.nix
    # ./yazi.nix
    ./superfile.nix
  ];

  home.packages = with pkgs; [
    btop
    procs
    dust
    eza
    fzf
    glow
    rainfrog
    unar
    jq
    yq-go
    vault
    kubectl
    kubernetes-helm
    hl-log-viewer
    devenv
    direnv
  ];

  programs = {
    bat = {
      enable = true;
    };

    posting = {
      enable = true;
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--iglob=!.git"
      ];
    };
  };
}
