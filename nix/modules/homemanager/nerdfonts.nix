{ config, lib, pkgs, username, ... }:
with lib;
let
  cfg = config.modules.nerdfonts;
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  options = {
    modules.nerdfonts = {
      enable = mkEnableOption "Nerd Fonts";
      fonts = mkOption {
        type = types.listOf types.str;
        default = [ "FiraCode" "VictorMono" "Iosevka" ];
        description = "	Fonts to install\n";
      };
    };
  };
  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs;
      [ (unstable.nerdfonts.override { fonts = cfg.fonts; }) ];
  };
}
