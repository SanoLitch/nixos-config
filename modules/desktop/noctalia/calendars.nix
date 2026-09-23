{ secrets, ... }: {
  programs.noctalia.settings.calendar = {
    enabled = true;

    account.yandex_work = {
      type = "caldav";
      name = "Work";
      provider = "custom";
      server_url = "https://caldav.yandex.ru";
      username = secrets.email.work.username;
      calendars = [ ];
      credential_source = "secret-service";
    };
  };
}
