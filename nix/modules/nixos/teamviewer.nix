{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.teamviewer;
in
{
  options = {
    modules.nixos.teamviewer = {
      enable = mkEnableOption "teamviewer";
      package = mkOption {
        type = types.package;
        default = pkgs.teamviewer;
      };
    };
  };

  config = mkIf cfg.enable {
    services.teamviewer = {
      enable = true;
      inherit (cfg) package;
    };
  };
}
