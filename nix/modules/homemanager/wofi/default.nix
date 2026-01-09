{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.wofi;
  settings = config.modules.homemanager.settings;
  colors = settings.theme.colors;
in
{
  options = {
    modules.homemanager.wofi = {
      enable = mkEnableOption "wofi";
      package = mkOption {
        type = types.package;
        default = pkgs.wofi;
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "wofi requires the hyprland window manager to be enabled";
      }
    ];

    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, D, exec, pkill wofi || ${getExe cfg.package} --show drun"
      "$mainMod, Space, exec, pkill wofi || ${getExe cfg.package} --show drun"
    ];

    programs.wofi = {
      enable = true;
      package = cfg.package;
      settings = {
        width = 425;
        height = 250;
        show = "drun";
        prompt = "Search...";
        allow_markup = true;
        no_actions = true;
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 30;
        normal_window = true;
        term = settings.terminal;
      };
      style = "	#window {\n		background-color: ${colors.base};\n		border-radius: 8px;\n	}\n\n	#input {\n		border-radius: 8px;\n		margin: 6px;\n		border: none;\n		color: white;\n		background-color: #222235;\n	}\n\n	#inner-box {\n		margin: 8px;\n	}\n\n	#entry:selected {\n		background: rgba(137, 181, 250, .6);\n		color: white;\n	}\n\n	#text {\n		color: white;\n	}\n  ";
    };
  };
}
