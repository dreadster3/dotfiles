{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.hypridle;
in {
  options = {
    modules.homemanager.hypridle = {
      enable = mkEnableOption "hypridle";
      package = mkOption {
        type = types.package;
        default = pkgs.hypridle;
        description = "The hyprlock package to use";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "hypridle requires the hyprland window manager to be enabled";
      }
      {
        assertion = config.programs.hyprlock.enable;
        message = "hypridle requires the hyprlock program to be enabled";
      }
    ];

    services.hypridle = {
      enable = true;
      package = cfg.package;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "${config.programs.hyprlock.package}/bin/hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "${config.programs.hyprlock.package}/bin/hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
