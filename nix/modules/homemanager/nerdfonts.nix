{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.nerdfonts;
in
{
  options = {
    modules.homemanager.nerdfonts = {
      enable = mkEnableOption "Nerd Fonts";
    };
  };
  config = mkIf cfg.enable { fonts.fontconfig.enable = true; };
}
