{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.bspwm;
in {
  options = { modules.nixos.bspwm = { enable = mkEnableOption "Bspwm"; }; };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.xserver.enable;
      message = "xserver must be enabled to use bspwm";
    }];

    services.xserver = { windowManager = { bspwm = { enable = true; }; }; };

    services.displayManager = {
      defaultSession = "none+bspwm";
      sddm.enable = true;
    };
  };
}
