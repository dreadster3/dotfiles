{ config, lib, pkgs, pkgs-unstable, ... }:
with lib;
let cfg = config.modules.homemanager.nerdfonts;
in {
  options = {
    modules.homemanager.nerdfonts = {
      enable = mkEnableOption "Nerd Fonts";
      fonts = mkOption {
        type = types.listOf types.str;
        default = [ "FiraCode" "VictorMono" "Iosevka" ];
        description = "Fonts to install";
      };
    };
  };
  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs;
      [ (pkgs-unstable.nerdfonts.override { fonts = cfg.fonts; }) ];
  };
}
