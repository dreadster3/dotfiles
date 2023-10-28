{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.picom;
in
{
  options = {
    modules.picom = {
      enable = mkEnableOption "picom";
      backend = mkOption {
        type = types.enum [ "glx" "xrender" "xr_glx_hybrid" "egl" ];
        default = "glx";
      };
    };
  };

  config = {
    services.picom = mkIf cfg.enable {
      enable = true;

      backend = cfg.backend;
      vSync = false;

      shadow = true;
      shadowOffsets = [ (-7) (-7) ];
      shadowExclude = [ "name = 'Notification'" ];

      fade = true;
      fadeSteps = [ 3.0e-2 3.0e-2 ];

      inactiveOpacity = 0.95;

      settings = {
        shadow-radius = 10;
        corner-radius = 10;
      };
    };

  };

}
