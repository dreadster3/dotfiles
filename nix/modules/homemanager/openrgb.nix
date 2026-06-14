{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.openrgb;
in
{
  options = {
    modules.homemanager.openrgb = {
      enable = mkEnableOption "openrgb";
      package = mkOption {
        type = types.package;
        default = pkgs.openrgb;
        description = "The package to install.";
      };
      startup = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "openrgb.startup";
            profile = mkOption {
              type = types.str;
              default = "blue+pink";
              description = "The profile to use on startup.";
            };
          };
        };
        default = { };
        description = "Start OpenRGB on boot.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
