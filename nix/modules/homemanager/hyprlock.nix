{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.hyprlock;
in {
  options = {
    modules.homemanager.hyprlock = {
      enable = mkEnableOption "hyprlock";
      package = mkOption {
        type = types.package;
        default = pkgs.hyprlock;
        description = "The hyprlock package to use";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "hyprlock requires the hyprland window manager to be enabled";
      }
      {
        assertion = !config.programs.swaylock.enable;
        message = "hyprlock is incompatible with swaylock";
      }
    ];

    wayland.windowManager.hyprland.settings.bind =
      [ "$mainMod_CTRL, Q, exec, ${cfg.package}/bin/hyprlock" ];

    programs.hyprlock = {
      enable = true;
      package = cfg.package;
      settings = {
        general = {
          disable_loading_bar = false;
          grace = 0;
          no_fade_in = true;
          no_fade_out = true;
          hide_cursor = true;
        };

        background = [{
          path = toString ../../../wallpapers/city_mountains.jpg;
          blur_passes = 1;
          blur_size = 5;
        }];

        input-field = [{
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
          shadow_passes = 2;
        }];
      };
    };

    systemd.user.services.hyprlock-suspend = {
      Unit = {
        Description = "Lock screen on suspend";
        After = [ "sleep.target" ];
      };
      Service = {
        Type = "forking";
        Environment = "DISPLAY=:0";
        ExecStart = "${cfg.package}/bin/hyprlock";
      };
      Install = { WantedBy = [ "sleep.target" ]; };
    };
  };
}
