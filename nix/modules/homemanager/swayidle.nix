{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.swayidle;
  locker_cmd = "${pkgs.swaylock}/bin/swaylock -fF";
in
{
  options = {
    modules.homemanager.swayidle = {
      enable = mkEnableOption "swayidle";
      package = mkOption {
        type = types.package;
        default = pkgs.swayidle;
        description = "The hyprlock package to use";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "swayidle requires the hyprland window manager to be enabled";
      }
      {
        assertion = !config.services.hypridle.enable;
        message = "swayidle cannot be enabled while hyrpidle is enabled";
      }
    ];

    services.swayidle = {
      enable = true;
      package = cfg.package;
      events = [
        {
          event = "lock";
          command = locker_cmd;
        }
        {
          event = "before-sleep";
          command = locker_cmd;
        }
      ];
      timeouts = [
        {
          timeout = 600;
          command = locker_cmd;
        }
        {
          timeout = 900;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
