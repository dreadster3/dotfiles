{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.hyprpaper;
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
      fitMode = mkOption {
        type = types.nullOr (types.enum [
          "fill"
          "contain"
          "cover"
          "tile"
          "stretch"
        ]);
        default = null;
        description = "fit_mode applied to every wallpaper; null omits the key";
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
      settings = {
        splash = false;
        wallpaper = mapAttrsToList (monitor: path: {
          inherit monitor;
          path = toString path;
        } // lib.optionalAttrs (cfg.fitMode != null) { fit_mode = cfg.fitMode; }) cfg.wallpapers;
      };
    };
  };
}
