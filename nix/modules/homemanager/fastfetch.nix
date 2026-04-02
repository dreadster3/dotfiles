{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.fastfetch;
in
{
  options = {
    modules.homemanager.fastfetch = {
      enable = mkEnableOption "fastfetch";
      package = mkPackageOption pkgs "fastfetch" { };
    };
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      inherit (cfg) package;
    };
  };
}
