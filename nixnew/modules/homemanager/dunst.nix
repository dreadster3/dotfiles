{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.dunst;
in {
  options = {
    modules.homemanager.dunst = { enable = mkEnableOption "dunst"; };
  };

  config = mkIf cfg.homemanager.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          title = "Dunst";
          class = "Dunst";
          frame_color = "#89B4FA";
          separator_color = "frame";
          corner_radius = 22;
          padding = 8;
          hide_duplicate_count = true;

          mouse_left_click = "close_current";
          mouse_middle_click = "do_action";
          mouse_right_click = "close_all";
        };
        urgency_low = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
        };

        urgency_normal = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
        };

        urgency_critical = {
          timeout = 0;
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          frame_color = "#FAB387";
        };
      };
    };
  };
}
