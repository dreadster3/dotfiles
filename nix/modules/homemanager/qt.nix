{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.qt;

in
{
  options = {
    modules.homemanager.qt = {
      enable = mkEnableOption "qt";
    };
  };
  config = mkIf cfg.enable {
    qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "kvantum";
    };
  };
}
