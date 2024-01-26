{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.bspwm;
in {
  options = {
    modules.bspwm = {
      enable = mkEnableOption "bspwm";

      monitor = mkOption {
        type = types.str;
        default = "DP-0";
        description = "The monitor to use for bspwm";
      };

      startupPrograms = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "The startup programs";
      };
    };
  };

  config = {
    xsession.windowManager.bspwm = mkIf cfg.enable {
      enable = true;
      settings = {
        focused_border_color = "#89B4FA";
        border_width = 3;
        window_gap = 10;

        split_ratio = 0.5;
        border_monocle = true;
        gapless_monocle = true;
      };
      startupPrograms = [
        "nitrogen --restore"
        "xsetroot -cursor_name left_ptr"
        "systemctl --user restart polybar.service"
      ] ++ cfg.startupPrograms;

      monitors = {
        "${cfg.monitor}" = [ "1" "2" "3" "4" "5" ];
        "HDMI-0" = [ "6" "7" "8" "9" "10" ];
      };
    };
  };

}
