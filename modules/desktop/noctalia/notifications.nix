{ ... }: {
  programs.noctalia.settings = {
    notification = {
      filter_order = [ "no_history" ];
      filter.no_history = {
        enabled = true;
        match_content = ".*";
        save_history = false;
      };
    };

  };
}
