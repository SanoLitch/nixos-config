{ pkgs, secrets, ... }:
let
  vpnConfig = secrets.vpn;
  inherit (vpnConfig) name host;

  vpnProfile = ''
    [connection]
    id=${name}
    uuid=657edaa9-4b92-4106-b7ca-3dddb59b1512
    type=vpn
    autoconnect=false

    [vpn]
    authtype=password
    autoconnect-flags=0
    certsigs-flags=0
    cookie-flags=2
    disable_udp=no
    enable_csd_trojan=no
    gateway=${host}
    gateway-flags=2
    gwcert-flags=2
    lasthost-flags=0
    pem_passphrase_fsid=no
    prevent_invalid_cert=no
    protocol=anyconnect
    resolve-flags=2
    stoken_source=disabled
    useragent=AnyConnect
    xmlconfig-flags=0
    service-type=org.freedesktop.NetworkManager.openconnect

    [vpn-secrets]
    form:main:group_list=Default-K
    lasthost=${host}

    [ipv4]
    method=auto

    [ipv6]
    addr-gen-mode=stable-privacy
    method=auto

    [proxy]
  '';
in
{
  environment.etc."NetworkManager/system-connections/VPN connection 1.nmconnection" = {
    text = vpnProfile;
    mode = "0600";
  };
  networking = {
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openconnect ];
    };
  };
}
