{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.swaylock;
in
{
  options = {
    modules.homemanager.swaylock = {
      enable = mkEnableOption "swaylock";
      package = mkOption {
        type = types.package;
        default = pkgs.swaylock;
        description = "The hyprlock package to use";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "swaylock requires the hyprland window manager to be enabled";
      }
      {
        assertion = !config.programs.hyprlock.enable;
        message = "swaylock cannot be enabled while hyprlock is enabled";
      }
    ];

    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod_CTRL, Q, exec, ${cfg.package}/bin/swaylock"
    ];

    programs.swaylock = {
      enable = true;
      package = cfg.package;
      settings = {
        image = toString ../../../wallpapers/city_mountains.jpg;
      };
    };

    systemd.user.services.swaylock-suspend = {
      Unit = {
        Description = "Lock screen on suspend";
        Before = [ "sleep.target" ];
      };
      Service = {
        Type = "forking";
        Environment = "DISPLAY=:0";
        ExecStart = "${cfg.package}/bin/swaylock";
      };
      Install = {
        WantedBy = [ "sleep.target" ];
      };
    };
  };
}
