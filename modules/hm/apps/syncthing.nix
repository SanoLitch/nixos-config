{ secrets, ... }: {
  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;

    settings = {
      devices = {
        "mac-mini-server" = {
          id = secrets.sync.server;
          autoAcceptFolders = false;
          introducer = true;
        };
      };
      options = {
        # globalAnnounceServers = [
        #   secrets.sync.radevousServerUrl
        # ];
        relaysEnabled = true;
      };
    };
  };
}
