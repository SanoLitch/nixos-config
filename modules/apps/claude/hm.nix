{
  config,
  pkgs,
  lib,
  ...
}:

let
  blockedCmd = pkgs.writeShellScript "blocked-cmd" ''
    echo "Permission denied" >&2
    exit 1
  '';

  mkStealth =
    {
      pkg,
      binName ? pkg.meta.mainProgram or (builtins.parseDrvName pkg.name).name,
    }:
    lib.hiPrio (
      pkgs.writeShellScriptBin binName ''
        unset LC_TIME LC_MONETARY LC_NUMERIC LC_PAPER LC_MEASUREMENT LC_ADDRESS LC_TELEPHONE
        unset DBUS_SESSION_BUS_ADDRESS DBUS_SYSTEM_BUS_ADDRESS
        unset SSH_AUTH_SOCK GPG_AGENT_INFO

        exec ${pkgs.bubblewrap}/bin/bwrap \
          --ro-bind /nix /nix \
          --ro-bind /run/current-system /run/current-system \
          --ro-bind-try /etc/profiles /etc/profiles \
          --ro-bind /bin /bin \
          --ro-bind-try /usr /usr \
          --ro-bind /etc/ssl /etc/ssl \
          --ro-bind /etc/static/ssl /etc/static/ssl \
          --ro-bind /etc/resolv.conf /etc/resolv.conf \
          --ro-bind /etc/hosts /etc/hosts \
          --ro-bind /etc/nsswitch.conf /etc/nsswitch.conf \
          --dev /dev \
          --proc /proc \
          --tmpfs /tmp \
          --tmpfs /run \
          --tmpfs /var \
          --bind "$HOME" "$HOME" \
          --dir "$XDG_RUNTIME_DIR" \
          --ro-bind "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/ip \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/iw \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/iwlist \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/nmcli \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/mmcli \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/ss \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/netstat \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/arp \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/traceroute \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/mtr \
          --ro-bind ${blockedCmd} /run/current-system/sw/bin/timedatectl \
          --unshare-pid \
          --unshare-ipc \
          --unshare-uts \
          --hostname "devbox" \
          --setenv TZ "UTC" \
          --setenv LC_ALL "C.UTF-8" \
          --setenv LANG "C.UTF-8" \
          -- ${pkg}/bin/${binName} "$@"
      ''
    );
in
{
  home.packages = with pkgs; [
    bubblewrap
    (mkStealth {
      pkg = claude-code;
      binName = "claude";
    })
  ];
}
