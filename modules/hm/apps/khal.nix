{ pkgs, ... }:
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
}