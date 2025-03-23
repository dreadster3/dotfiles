{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.nixos.i3;
  desktopManager = if config.services.xserver.desktopManager.xfce.enable then
    "xfce"
  else
    "none";
in {
  options = { modules.nixos.i3 = { enable = mkEnableOption "i3"; }; };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.xserver.enable;
      message = "xserver must be enabled to use xfce";
    }];

    services.xserver.windowManager.i3.enable = true;

    services.xserver.desktopManager.xterm.enable = false;

    services.displayManager.defaultSession = mkDefault "${desktopManager}+i3";

    home-manager.sharedModules = [{
      modules.homemanager = {
        i3.enable = mkDefault true;
        polybar.enable = mkDefault true;
        rofi.enable = mkDefault true;
        betterlockscreen.enable = mkDefault true;
        autolock.enable = mkDefault true;
        nitrogen.enable = mkDefault true;
      };
    }];
  };
}
