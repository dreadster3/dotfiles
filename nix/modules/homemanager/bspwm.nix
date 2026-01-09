{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.bspwm;
  monitors = config.modules.homemanager.settings.monitors.x11 // cfg.monitors;
in
{
  options = {
    modules.homemanager.bspwm = {
      enable = mkEnableOption "bspwm";

      monitors = mkOption {
        type = types.monitorMap;
        description = "The monitors and their desktops";
        default = { };
      };

      startupPrograms = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "The startup programs";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = monitors != { };
        message = "No monitors configured";
      }
    ];

    services.polybar.config."bar/main".wm-restack = "bspwm";

    xsession.windowManager.bspwm = {
      enable = true;
      settings = {
        border_width = 3;
        window_gap = 10;

        split_ratio = 0.5;
        borderless_monocle = true;
        gapless_monocle = true;

        pointer_follows_focus = false;
        focus_follows_pointer = true;

        right_padding = 0;
        bottom_padding = 0;
      };

      startupPrograms = cfg.startupPrograms ++ [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "xsetroot -cursor_name left_ptr"
      ];

      monitors = mapAttrs (name: monitor: (map (value: toString value) monitor.workspaces)) monitors;

      rules = {
        "Pavucontrol" = {
          state = "floating";
          center = true;
        };
        ".guake-wrapped" = {
          state = "floating";
          sticky = true;
          center = true;
        };
        "Zathura" = {
          state = "tiled";
        };
        "GeForce NOW" = {
          state = "fullscreen";
        };
      };
    };
  };

}
