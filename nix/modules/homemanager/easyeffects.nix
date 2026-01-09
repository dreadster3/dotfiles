{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.easyeffects;
in
{
  options = {
    modules.homemanager.easyeffects = {
      enable = mkEnableOption "easyeffects";
      package = mkOption {
        type = types.package;
        default = pkgs.easyeffects;
      };
    };
  };

  config = mkIf cfg.enable {
    services.easyeffects = {
      enable = true;
    };
  };
}
