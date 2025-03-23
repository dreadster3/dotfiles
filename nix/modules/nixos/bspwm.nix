{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.bspwm;
in
{
  options = { modules.nixos.bspwm = { enable = mkEnableOption "bspwm"; }; };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.xserver.enable;
      message = "xserver must be enabled to use bspwm";
    }];

    services.xserver.windowManager.bspwm.enable = true; };

    services.xserver.desktopManager.xterm.enable = false;

    services.displayManager.defaultSession = mkDefault "none+bspwm";

    home-manager.sharedModules =
      [{ modules.homemanager.bspwm.enable = mkDefault true; }];
  };
}
