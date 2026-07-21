{ ... }:
{
  imports = [
    ./cloudflared.nix
    ./forgejo.nix
    ./jackett.nix
    ./syncthing.nix
    ./torrserver.nix
  ];
}
