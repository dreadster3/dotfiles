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
      mimeApps = {
        enable = true;
        defaultApplications = {
          "x-www-browser" = "${cfg.package.meta.mainProgram}.desktop";
          "text-html" = "${cfg.package.meta.mainProgram}.desktop";
          "x-scheme-handler/http" = "${cfg.package.meta.mainProgram}.desktop";
          "x-scheme-handler/https" = "${cfg.package.meta.mainProgram}.desktop";
          "application/x-extension-htm" =
            "${cfg.package.meta.mainProgram}.desktop";
          "application/x-extension-html" =
            "${cfg.package.meta.mainProgram}.desktop";
          "application/x-extension-shtml" =
            "${cfg.package.meta.mainProgram}.desktop";
          "application/xhtml+xml" = "${cfg.package.meta.mainProgram}.desktop";
          "application/x-extension-xhtml" =
            "${cfg.package.meta.mainProgram}.desktop";
          "application/x-extension-xht" =
            "${cfg.package.meta.mainProgram}.desktop";
        };
      };
    };
  };
}
