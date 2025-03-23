{ pkgs, name, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.firefox;
in {
  options = {
    modules.homemanager.firefox = {
      enable = mkEnableOption "firefox";
      package = mkOption {
        type = types.package;
        default = pkgs.firefox-devedition;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg = {
      desktopEntries = {
        firefox = {
          name = "Firefox";
          exec = getExe cfg.package;
          terminal = false;
          genericName = "Web Browser";
          icon = "firefox";
          mimeType = [
            "text/html"
            "text/xml"
            "application/xhtml+xml"
            "application/vnd.mozilla.xul+xml"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
          ];
        };
      };

      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "x-www-browser" = "firefox.desktop";
          "text-html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
        };
      };
    };
  };
}
