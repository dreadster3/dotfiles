{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.gammastep;
in
{
  options = {
    modules.homemanager.gammastep = {
      enable = mkEnableOption "gammastep";
    };
  };

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 39.0;
      longitude = -9.0;
      tray = true;
    };
  };
}
