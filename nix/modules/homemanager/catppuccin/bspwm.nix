{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.wayland.windowManager.hyprland.catppuccin;
  colors = config.catppuccin.colors;
in
{
  options = { };

  config = mkIf cfg.enable {
    xsession.windowManager.bspwm.settings = {
      normal_border_color = colors.surface1;
      active_border_color = colors.teal;
      focused_border_color = colors.accent;
      presel_feedback_color = colors.base;
    };
  };
}
