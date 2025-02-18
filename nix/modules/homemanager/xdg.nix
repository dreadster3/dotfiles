{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.xdg;
in {
  options = { modules.homemanager.xdg = { enable = mkEnableOption "xdg"; }; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ xdg-utils ];

    xdg = {
      desktopEntries = {
        firefox = {
          name = "Firefox";
          exec = getExe config.modules.homemanager.firefox.package;
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

      mimeApps = {
        enable = true;
        defaultApplications = {
          "x-www-browser" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
        };
      };
    };
  };
}
