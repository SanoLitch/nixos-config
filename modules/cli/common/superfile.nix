{ pkgs, inputs, ... }: {
  # home.packages = with pkgs; [
  #   inputs.superfile.packages.${system}.default
  # ];
  #

  programs.superfile = {
    enable = true;
    package = inputs.superfile.packages.${pkgs.system}.default;
    firstUseCheck = false;
    settings = {
      auto_check_update = false;
    };
  };
}
