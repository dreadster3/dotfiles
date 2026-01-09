{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.krew;
in
{
  options = {
    modules.homemanager.krew = {
      enable = mkEnableOption "krew";
      package = mkOption {
        type = types.package;
        default = pkgs.krew;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionPath = [ "${config.home.homeDirectory}/.krew/bin" ];
  };
}
