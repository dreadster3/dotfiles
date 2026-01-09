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

    qt.enable = true;
    qt.style.name = "kvantum";
    qt.platformTheme.name = "kvantum";
  };
}
