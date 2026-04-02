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
      package = mkPackageOption pkgs "bat" { };
    };
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      inherit (cfg) package;
    };
  };
}
