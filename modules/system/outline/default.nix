{
  pkgs,
  secrets,
  ...
}:
let
  outlineBinary = ./outline-cli;

  outline-cli = pkgs.stdenv.mkDerivation {
    pname = "outline-cli";
    version = "1.0.0";

    src = outlineBinary;

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/outline-cli
      chmod +x $out/bin/outline-cli
    '';

    doInstallCheck = true;
    installCheckPhase = ''
      $out/bin/outline-cli -help > /dev/null
    '';

    meta = with pkgs.lib; {
      description = "Outline VPN CLI client (pre-built binary)";
      homepage = "https://github.com/Jigsaw-Code/outline-sdk";
      license = licenses.asl20;
    };
  };
in
{
  environment.systemPackages = [
    outline-cli
    (pkgs.writeScriptBin "start-outline" ''
      #!${pkgs.bash}/bin/bash
      ${outline-cli}/bin/outline-cli -transport "${secrets.outline}"
    '')
  ];
}
