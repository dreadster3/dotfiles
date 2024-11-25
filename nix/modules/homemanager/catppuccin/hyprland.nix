{ pkgs, lib, config, ... }:
with lib;
let cfg = config.wayland.windowManager.hyprland.catppuccin;
in {
  options = { };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      # decoration.shadow.color = "$base";
      decoration."col.shadow" = "$base";
      general = {
        "col.active_border" = "$accent";
        "col.inactive_border" = "$surface1";
      };
      group = {
        "col.border_active" = "$accent";
        "col.border_inactive" = "$surface1";
        "col.border_locked_active" = "$teal";
        groupbar = {
          text_color = "$text";
          "col.active" = "$accent";
          "col.inactive" = "$surface1";
        };
      };
      misc.background_color = "$base";
    };
  };
}
