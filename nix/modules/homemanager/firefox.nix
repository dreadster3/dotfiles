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
    home.packages = with pkgs; [ cfg.package xdg-utils ];

    xdg = {
      mime.enable = true;
      mimeApps.defaultApplications = {
        "x-www-browser" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "text/html" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "x-scheme-handler/http" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "x-scheme-handler/https" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/x-extension-htm" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/x-extension-html" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/x-extension-shtml" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/xhtml+xml" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/xhtml_xml" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/x-extension-xhtml" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/x-extension-xht" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop";
      };
    };
  };
}
