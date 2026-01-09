{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.mpv;
in
{
  options = {
    modules.homemanager.mpv = {
      enable = mkEnableOption "mpv";
      package = mkOption {
        type = types.package;
        default = pkgs.mpv;
      };
    };
  };
  config = mkIf cfg.enable {
    programs.mpv = {
      inherit (cfg) package;
      enable = true;
    };

    xdg.mimeApps.defaultApplications = {
      "video/mp4" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-matroska" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/webm" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/quicktime" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-msvideo" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-flv" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/mpeg" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/3gpp" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/3gpp2" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/ogg" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-ms-wmv" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-ms-asf" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/h264" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/hevc" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-theora" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-dirac" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-m4v" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
      "video/x-f4v" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
    };
  };
}
