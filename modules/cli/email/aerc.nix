{ pkgs, ... }:
{
  programs.aerc = {
    enable = true;
    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
      };
      ui = {
        sidebar-width = 25;
        mouse-enabled = true;
      };
      viewer = {
        pager = "less -R";
      };
            filters = {
              "text/plain" = "colorize";
              "text/html" = "html | colorize";
              ".headers" = "colorize";
            };
            openers = {
              # Ассоциируем MIME-тип приглашений с khal import
              "text/calendar" = "khal import -d private_1_cal"; # Используем имя календаря по умолчанию
            };
            triggers = {
              # Integration with dunst via notify-send for manual checks or when aerc is running
              new-email = "exec notify-send \"New email from %n\" \"%s\"";
            };
          };
        };
  programs.mbsync.enable = true;

  services.mbsync = {
    enable = true;
    frequency = "*:0/5"; # Check mail every 5 minutes
    postExec = "${pkgs.writeShellScript "mail-notify" ''
      STATE_FILE="$HOME/.cache/mail_new_count"

      # Count new files only in Inbox/new directories (case insensitive for Inbox/INBOX)
      NEW_COUNT=$(find ~/Maildir -type f \( -path "*/Inbox/new/*" -o -path "*/INBOX/new/*" \) | wc -l)

      # Read old count                   
      if [ -f "$STATE_FILE" ]; then
        OLD_COUNT=$(cat "$STATE_FILE")
      else
        OLD_COUNT=0
      fi

      # Save current count
      echo "$NEW_COUNT" > "$STATE_FILE"

      # Notify only if count increased
      if [ "$NEW_COUNT" -gt "$OLD_COUNT" ]; then
        DIFF=$((NEW_COUNT - OLD_COUNT))
        ${pkgs.libnotify}/bin/notify-send "New Mail" "You have $DIFF new message(s) ($NEW_COUNT total)."
      fi
    ''}";
  }; # Dependencies for rendering html, etc.

  home.packages = with pkgs; [
    w3m
  ];
}
