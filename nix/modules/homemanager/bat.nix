{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.bat;
in
{
  options = {
    modules.homemanager.bat = {
      enable = mkEnableOption "bat";
    };
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
  };
}
