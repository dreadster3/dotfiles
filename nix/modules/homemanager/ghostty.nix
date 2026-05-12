{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.ghostty;
  inherit (config.modules.homemanager) settings;
in
{
  options = {
    modules.homemanager.ghostty = {
      enable = mkEnableOption "ghostty";
      package = mkPackageOption pkgs "ghostty" { };
    };
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      inherit (cfg) package;
      enableZshIntegration = false;

      settings = {
        font-size = settings.font.size;
        font-family = settings.font.normal.family;
        font-style = settings.font.normal.style;
        font-family-italic = settings.font.italic.family;
        font-style-italic = settings.font.italic.style;
        background-opacity = 0.8;
        window-padding-x = 20;
        window-padding-y = 20;
        window-padding-balance = true;
        window-decoration = "none";
        window-inherit-working-directory = false;
      };
    };

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/terminal" = mkDefault "ghostty.desktop";
      "application/x-terminal-emulator" = mkDefault "ghostty.desktop";
    };
  };
}
