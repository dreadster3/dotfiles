{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nixos.archive;
in {
  options = {
    modules.nixos.archive = {
      enable = mkEnableOption "archive";
      package = mkOption {
        type = types.package;
        default = pkgs.file-roller;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.file-roller = {
      inherit (cfg) package;
      enable = true;
    };

    home-manager.sharedModules = [{
      xdg.mimeApps.defaultApplications = {
        "application/zip" = mkDefault "${cfg.package.meta.mainProgram}.desktop";
        "application/x-zip-compressed" = mkDefault
          "${cfg.package.meta.mainProgram}.desktop"; # Alternate for .zip
        "application/x-tar" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop"; # .tar
        "application/x-gzip" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop"; # .gz, .tgz
        "application/x-bzip2" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop"; # .bz2, .tbz
        "application/x-xz" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop"; # .xz, .txz
        "application/x-7z-compressed" =
          mkDefault "${cfg.package.meta.mainProgram}.desktop"; # .7z
        "application/x-rar" = mkDefault
          "${cfg.package.meta.mainProgram}.desktop"; # .rar (deprecated by rar5, but still common)
        "application/x-rar-compressed" = mkDefault
          "${cfg.package.meta.mainProgram}.desktop"; # .rar (more specific for newer rar versions)
      };
    }];
  };
}
