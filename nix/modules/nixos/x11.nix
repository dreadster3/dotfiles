{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.x11;
in {
  options = { modules.nixos.x11 = { enable = mkEnableOption "X11"; }; };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb.layout = "us";
    };

    environment.systemPackages = with pkgs; [ betterlockscreen xclip ];

    qt.enable = true;

    home-manager.sharedModules = [{
      modules.homemanager = {
        autolock.enable = mkDefault true;
        flameshot.enable = mkDefault true;
        nitrogen.enable = mkDefault true;
      };
    }];
  };
}
