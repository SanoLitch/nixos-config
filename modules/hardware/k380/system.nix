{ pkgs, ... }:

{
  # Включаем официальную поддержку Logitech через Solaar.
  # Это автоматически добавит нужные udev-правила, модуль hid_logitech_hidpp
  # и установит GUI/CLI утилиту solaar.
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
}
