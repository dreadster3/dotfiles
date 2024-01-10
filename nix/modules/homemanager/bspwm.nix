{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.bspwm;
in {
  options = {
    modules.bspwm = {
      enable = mkEnableOption "bspwm";

      monitor = mkOption {
        type = types.str;
        default = "eDP-1";
        description = "The monitor to use for bspwm";
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
        "vmware-user"
        "xsetroot -cursor_name left_ptr"
        "systemctl --user restart polybar.service"
      ];

      monitors = { "${cfg.monitor}" = [ "1" "2" "3" "4" "5" ]; };
    };
  };

}
