{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.catppuccin.dunst;
  inherit (config.catppuccin) colors;
in
{
  options = { };

  config = mkIf cfg.enable {
    services.dunst.settings = {
      global = {
        frame_color = colors.accent;
        separator_color = "frame";
      };
      urgency_low = {
        background = colors.base;
        foreground = colors.text;

      };
      urgency_normal = {
        background = colors.base;
        foreground = colors.text;
      };
      urgency_critical = {
        background = colors.base;
        foreground = colors.text;
        frame_color = colors.peach;
      };
    };
  };
}
