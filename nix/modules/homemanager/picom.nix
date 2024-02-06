{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.picom;
in {
  options = {
    modules.picom = {
      enable = mkEnableOption "picom";
      backend = mkOption {
        type = types.enum [ "glx" "xrender" "xr_glx_hybrid" "egl" ];
        default = "glx";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.picom = lib.mkForce { };
    services.picom = {
      enable = true;

      backend = cfg.backend;
      vSync = false;

      shadow = true;
      shadowOffsets = [ (-7) (-7) ];
      shadowExclude = [ "name = 'Notification'" "class_g = 'Dunst'" ];

      fade = true;
      fadeSteps = [ 3.0e-2 3.0e-2 ];

      inactiveOpacity = 0.95;
      opacityRules = [ "100:class_g = 'i3lock'" ];

      settings = {
        experimental-backends = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;
        glx-no-stencil = true;
        use-damage = true;

        shadow-radius = 18;
        corner-radius = 22.5;

        rounded-corners-exclude = [
          # Window types
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'popup'"
          "window_type = 'dock'"
          "window_type = 'tooltip'"

          # Classes
          "class_g = 'Polybar'"
        ];

        blur-background-exclude = [ "class_g = 'Dunst'" ];
      };

      wintypes = {
        normal = {
          fade = true;
          shadow = true;
        };
        tooltip = {
          fade = false;
          shadow = false;
          focus = true;
          full-shadow = false;
        };
        dock = {
          shadow = false;
          clip-shadow-above = false;
        };
        dnd = { shadow = false; };
      };
    };

  };

}
