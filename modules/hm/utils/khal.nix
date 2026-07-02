{ pkgs, ... }:
let
  khal-notify = pkgs.writeShellScript "khal-notify" ''
    STATE_DIR="''${XDG_RUNTIME_DIR:-/tmp}/khal-notify"
    mkdir -p "$STATE_DIR"

    NOW=$(date +'%d.%m.%Y %H:%M')
    FUTURE=$(date -d '+15 minutes' +'%d.%m.%Y %H:%M')

    ${pkgs.khal}/bin/khal list \
      --format "{uid}|||{title}|||{start-time}|||{calendar}" \
      "$NOW" "$FUTURE" 2>/dev/null \
    | while IFS='|||' read -r uid title time calendar; do
        [ -z "$uid" ] || [ -z "$title" ] && continue
        HASH=$(printf '%s' "$uid" | ${pkgs.coreutils}/bin/md5sum | cut -d' ' -f1)
        MARKER="$STATE_DIR/$HASH"
        if [ ! -f "$MARKER" ]; then
          ${pkgs.libnotify}/bin/notify-send \
            --urgency=normal \
            --icon=calendar \
            "📅 $title" \
            "Начинается в $time ($calendar)"
          touch "$MARKER"
        fi
      done

    # Удаляем маркеры старше 2 дней
    find "$STATE_DIR" -type f -mtime +2 -delete 2>/dev/null || true
  '';
in
{
  home.packages = [
    pkgs.khal
    pkgs.vdirsyncer
  ];

  xdg.configFile."khal/config".text = ''
    [calendars]

    [[private_calendars]]
    path = ~/.calendars/private_1/*
    type = discover
    color = light blue

    [[work_calendars]]
    path = ~/.calendars/work/*
    type = discover
    color = light green

    [locale]
    timeformat = %H:%M
    dateformat = %d.%m.%Y
    longdateformat = %d.%m.%Y
    datetimeformat = %d.%m.%Y %H:%M
    firstweekday = 0

    [default]
    timedelta = 2d

    [view]
    agenda_event_format = {calendar-color}{start-end-time-style} {title}{reset}
  '';

  services.vdirsyncer = {
    enable = true;
    frequency = "*:0/15";
  };

  systemd.user.services.khal-notify = {
    Unit.Description = "Khal calendar notifications";
    Service = {
      Type = "oneshot";
      ExecStart = "${khal-notify}";
    };
  };

  systemd.user.timers.khal-notify = {
    Unit.Description = "Run khal-notify every minute";
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      Unit = "khal-notify.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}