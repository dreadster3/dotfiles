{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.thunderbird;
in
{
  options = {
    modules.homemanager.thunderbird = {
      enable = mkEnableOption "thunderbird";
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ thunderbird ]; };
}
