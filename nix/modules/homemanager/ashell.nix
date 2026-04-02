{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.ashell;
in
{
  options = {
    modules.homemanager.ashell = {
      enable = mkEnableOption "ashell";
      package = mkPackageOption pkgs "ashell" { };
    };
  };

  config = mkIf cfg.enable {
    programs.ashell = {
      enable = true;
      inherit (cfg) package;
      systemd.enable = true;
    };
  };
}
