{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.bspwm;
in {
  options = { modules.bspwm = { enable = mkEnableOption "bspwm"; }; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ fusuma ];
    services.xserver = {
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        touchpad = { naturalScrolling = true; };
      };
      # xkbVariant = "";
      windowManager = { bspwm = { enable = true; }; };
      displayManager = {
        defaultSession = "none+bspwm";
        lightdm = {
          enable = true;
          greeter = { enable = true; };
        };
        startx.enable = true;
      };
    };
  };
}
