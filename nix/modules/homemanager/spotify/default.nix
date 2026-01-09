{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.spotify;
in
{

  options = {
    modules.homemanager.spotify = {
      enable = mkEnableOption "spotify";
      package = mkOption {
        type = types.package;
        default = pkgs.spotify;
        description = "The package to install spotify";
      };
      spicetify = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "spotify.spicetify";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.spicetify = {
      inherit (cfg.spicetify) enable;
      theme = pkgs.spicetifyPackages.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
