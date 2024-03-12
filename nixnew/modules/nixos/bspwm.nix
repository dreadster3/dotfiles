{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.bspwm;
in {
  options = { modules.nixos.bspwm = { enable = mkEnableOption "Bspwm"; }; };

  config = mkIf cfg.enable {
    assertions = [ services.xserver.enable ];

    services.xserver = {
      windowManager = { bspwm = { enable = true; }; };
      displayManager = {
        defaultSession = "none+bspwm";
        sddm.enable = true;
        startx.enable = true;
      };
    };
  };
}
