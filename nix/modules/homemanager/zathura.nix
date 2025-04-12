{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.zathura;
in {
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

    xdg = {
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = mkDefault "org.pwmt.zathura.desktop";
        };
      };
    };
  };
}
