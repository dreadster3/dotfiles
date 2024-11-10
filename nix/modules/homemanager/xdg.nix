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
          name = "firefox";
          exec = getExe config.modules.homemanager.firefox.package;
        };
      };

      mimeApps = {
        enable = true;
        defaultApplications = { "x-www-browser" = "firefox.desktop"; };
      };
    };
  };
}
