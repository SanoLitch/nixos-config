{ pkgs, secrets, ... }:
{
  accounts.email.accounts.private_1 = {
    primary = true;
    address = secrets.email.private_1.address;
    userName = secrets.email.private_1.username;
    realName = secrets.email.private_1.name;
    passwordCommand = "${pkgs.coreutils}/bin/printf '${secrets.email.private_1.password}'";

    imap = {
      host = secrets.email.private_1.imap.host;
      port = secrets.email.private_1.imap.port;
      tls.enable = true;
    };

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };

    aerc = {
      enable = true;
    };
  };

  accounts.email.accounts.private_2 = {
    address = secrets.email.private_2.address;
    userName = secrets.email.private_2.username;
    realName = secrets.email.private_2.name;
    passwordCommand = "${pkgs.coreutils}/bin/printf '${secrets.email.private_2.password}'";

    imap = {
      host = secrets.email.private_2.imap.host;
      port = secrets.email.private_2.imap.port;
      tls.enable = true;
    };

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };

    aerc = {
      enable = true;
    };
  };

  accounts.email.accounts.work = {
    address = secrets.email.work.address;
    userName = secrets.email.work.username;
    realName = secrets.email.work.name;
    passwordCommand = "${pkgs.coreutils}/bin/printf '${secrets.email.work.password}'";

    imap = {
      host = secrets.email.work.imap.host;
      port = secrets.email.work.imap.port;
      tls.enable = true;
    };

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };

    aerc = {
      enable = true;
    };
  };
}
