{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.homemanager.dunst;
  colors = config.modules.homemanager.settings.theme.colors;
in {
  options = {
    modules.homemanager.dunst = { enable = mkEnableOption "dunst"; };
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          title = "Dunst";
          class = "Dunst";
          corner_radius = 22;
          padding = 8;
          hide_duplicate_count = true;

          mouse_left_click = "do_action";
          mouse_right_click = "close_current";
          mouse_middle_click = "close_all";
        };

        urgency_critical = { timeout = 0; };
      };
    };
  };
}
