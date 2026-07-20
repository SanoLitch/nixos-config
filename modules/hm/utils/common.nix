{ pkgs, ... }: {
  home.packages = with pkgs; [
    btop
    eza
    lazysql
    lazydocker
    unar
    jq
  ];
}
