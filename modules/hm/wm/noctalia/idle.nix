{ ... }:
{
  programs.noctalia-shell.settings.idle = {
    enabled = true;
    screenOffTimeout = 900;
    lockTimeout = 1020;
    suspendTimeout = 1500;
    fadeDuration = 10;
    screenOffCommand = "";
    lockCommand = "";
    suspendCommand = "";
    resumeScreenOffCommand = "";
    resumeLockCommand = "";
    resumeSuspendCommand = "";
    customCommands = "[]";
  };
}
