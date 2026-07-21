{ ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      settings = {
        connection = {
          "wifi.cloned-mac-address" = "permanent";
        };
      };
    };
  };
}
