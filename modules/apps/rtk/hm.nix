{ pkgs, lib, ... }:
let
  proxyBind = "127.0.0.1:8080";

  # Daemon behind `rtk llm-proxy`: a separate BUSL-1.1 release archive, not in nixpkgs.
  # rtk finds it on PATH.
  rtk-proxy = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "rtk-proxy";
    version = "1.1.0";
    src = pkgs.fetchurl {
      url = "https://github.com/rtk-ai/rtk/releases/download/v${version}/rtk-proxy-x86_64-unknown-linux-musl.tar.gz";
      hash = "sha256-V2Qw1/P9/EtUwFptpbp5v1333esUaanAKJPt9bggoPs=";
    };
    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      install -Dm755 rtk-proxy $out/bin/rtk-proxy
    '';
    meta = {
      mainProgram = "rtk-proxy";
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  home.packages = [
    pkgs.rtk
    rtk-proxy
  ];

  home.activation.rtkInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${lib.getExe pkgs.rtk} init --global --agent claude --auto-patch
    run ${lib.getExe pkgs.rtk} init --global --agent antigravity --auto-patch
  '';

  systemd.user.services.rtk-proxy = {
    Unit.Description = "RTK LLM proxy daemon";
    Service = {
      ExecStart = "${lib.getExe rtk-proxy} start";
      Environment = [ "RTK_PROXY_BIND=${proxyBind}" ];
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = [ "default.target" ];
  };

  # Route Claude Code through the proxy.
  home.sessionVariables.ANTHROPIC_BASE_URL = "http://${proxyBind}";
}
