{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.eog;
in {
  options = {
    modules.homemanager.eog = {
      enable = mkEnableOption "eog";
      package = mkOption {
        type = types.package;
        default = pkgs.eog;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.mimeApps.defaultApplications = {
      "image/png" = mkDefault "org.gnome.eog.desktop";
      "image/jpeg" = mkDefault "org.gnome.eog.desktop";
      "image/gif" = mkDefault "org.gnome.eog.desktop";
      "image/bmp" = mkDefault "org.gnome.eog.desktop";
      "image/tiff" = mkDefault "org.gnome.eog.desktop";
      "image/webp" = mkDefault "org.gnome.eog.desktop";
    };
  };
}
