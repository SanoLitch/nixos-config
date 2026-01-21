{
  pkgs,
  lib,
  secrets,
  ...
}:
let
  # Хелпер для генерации конфига одной пары (локальный <-> удаленный)
  mkAccountConfig =
    name: account: serviceType:
    let
      remoteUrl =
        if serviceType == "gmail" then
          "https://www.google.com/calendar/dav/${account.address}/user"
        else
          "https://caldav.yandex.ru/";
      passwordToUse = if account ? password_calendar then account.password_calendar else account.password;
    in
    ''
      [pair ${name}]
      a = "${name}_local"
      b = "${name}_remote"
      collections = ["from b", "from a"]

      [storage ${name}_local]
        type = "filesystem"
        path = "~/.calendars/${name}"
        fileext = ".ics"

        [storage ${name}_remote]
        type = "caldav"
        url = "${remoteUrl}"
        username = "${account.username}"
        password.fetch = ["command", "printf", "${passwordToUse}"]
    '';
in
{
  # Генерируем конфиг vdirsyncer
  home.file.".config/vdirsyncer/config".text = ''
    [general]
    status_path = "~/.local/share/vdirsyncer/status/"

    ${mkAccountConfig "private_1" secrets.email.private_1 "gmail"}
    ${mkAccountConfig "private_2" secrets.email.private_2 "gmail"}
    ${mkAccountConfig "work" secrets.email.work "yandex"}
  '';

  # Скрипт активации для создания папок, чтобы vdirsyncer не ругался
  home.activation.createCalendarDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.calendars/private_1
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.calendars/private_2
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.calendars/work
  '';
}
