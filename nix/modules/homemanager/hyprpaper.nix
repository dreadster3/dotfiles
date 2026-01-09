{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.hyprpaper;
  # mappedAttrs = mapAttrs (monitor: wallpaper: toString wallpaper) cfg.wallpapers;
in
{
  options = {
    modules.homemanager.hyprpaper = {
      enable = mkEnableOption "hyprpaper";
      package = mkOption {
        type = types.package;
        default = pkgs.hyprpaper;
      };
      wallpapers = mkOption {
        type = types.attrsOf types.path;
        default = {
          "" = ../../../wallpapers/city_mountains.jpg;
        };
        description = "The wallpapers to use";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "hyprpaper requires the hyprland window manager to be enabled";
      }
    ];

    services.hyprpaper = {
      enable = true;
      # NOTE: not working due to configuration breaking change
      #
      # settings = {
      #   preload = attrValues mappedAttrs;
      #   wallpaper = mapAttrsToList (monitor: wallpaper: "${monitor},${wallpaper}") mappedAttrs;
      # };
    };
  };
}
