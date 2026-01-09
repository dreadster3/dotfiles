{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.qt;

in
{
  options = {
    modules.nixos.qt = {
      enable = mkEnableOption "qt";
    };
  };
  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };

    home-manager.sharedModules = [ { modules.homemanager.qt.enable = mkDefault true; } ];
  };
}
