{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.autolock;
in {
  options = {
    modules.homemanager.autolock = { enable = mkEnableOption "autolock"; };
  };

  config = mkIf cfg.enable {
    xidlehook = {
      enable = true;
      not-when-audio = true;
      not-when-fullscreen = true;

      timers = [
        {
          delay = 5 * 60;
          command =
            "${pkgs.libnotify}/bin/notify-send 'Inactive' 'Locking session in 5 minutes'";
          canceller =
            "${pkgs.libnotify}/bin/notify-send 'Activity detected' 'Lock session cancelled'";
        }
        {
          # Lock the session after 10 min idle
          delay = 10 * 60;
          command = "loginctl lock-session";
        }
        {
          # Suspend the system after 15 min idle
          delay = 15 * 60;
          command = "systemctl suspend";
        }
      ];
    };

    services.screen-locker.enable = true;

    # Disable xautolock to use xidlehook
    servcies.screen-locker.xautolock.enable = false;
  };
}
