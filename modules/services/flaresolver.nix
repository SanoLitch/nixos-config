{
  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    autoStart = true;
    ports = [
      "8191:8191"
    ];
    environment = {
      LOG_LEVEL = "info";
      CAPTCHA_SOLVER = "none";
      TZ = "Europe/Moscow";
    };
  };
}
