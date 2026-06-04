{ lib, config, ... }:
with lib;
let
  cfg = config.catppuccin.hyprland;
  mkInline = lib.generators.mkLuaInline;
in
{
  options = { };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      config = {
        decoration.shadow.color = mkInline "colors.base";
        general = {
          col = {
            active_border = mkInline "colors.accent";
            inactive_border = mkInline "colors.surface1";
          };
        };
        group = {
          col = {
            border_active = mkInline "colors.accent";
            border_inactive = mkInline "colors.surface1";
            border_locked_active = mkInline "colors.teal";
          };
          groupbar = {
            col = {
              active = mkInline "colors.accent";
              inactive = mkInline "colors.surface1";
            };
            text_color = mkInline "colors.text";
          };
        };
        misc.background_color = mkInline "colors.base";
      };
    };
  };
}
