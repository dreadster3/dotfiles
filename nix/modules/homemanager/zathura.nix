{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.zathura;
in
{
  options = {
    modules.homemanager.zathura = {
      enable = mkEnableOption "zathura";
      package = mkOption {
        type = types.package;
        default = pkgs.zathura;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      package = cfg.package;
    };

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = mkDefault "org.pwmt.zathura.desktop";
    };
  };
}
