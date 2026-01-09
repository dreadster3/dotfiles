{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.fusuma;
in
{
  options = {
    modules.homemanager.fusuma = {
      enable = mkEnableOption "fusuma";
    };
  };

  config = mkIf cfg.enable {
    services.fusuma = {
      enable = true;
      settings = {
        swipe = {
          "3" = {
            left = {
              command = "${pkgs.bspwm}/bin/bspc desktop -f next.local";
            };
            right = {
              command = "${pkgs.bspwm}/bin/bspc desktop -f prev.local";
            };
          };
        };
      };
    };
  };
}
