{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.nerdfonts;
in {
  options = {
    modules.homemanager.nerdfonts = {
      enable = mkEnableOption "Nerd Fonts";
      package = mkOption {
        type = types.package;
        default = pkgs.nerdfonts;
        description = "The Nerd Fonts package to install";
      };
      fonts = mkOption {
        type = types.listOf types.str;
        default = [ "FiraCode" "VictorMono" "Iosevka" ];
        description = "Fonts to install";
      };
    };
  };
  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = [ (cfg.package.override { fonts = cfg.fonts; }) ];
  };
}
