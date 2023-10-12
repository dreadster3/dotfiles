{ config, pkgs, lib, ...}:

{
  services.xserver = {
    enable = true;
    layout = "us";
    # xkbVariant = "";
    windowManager = {
      bspwm = {
        enable = true;
      };
    };
    displayManager = {
      defaultSession = "none+bspwm";
      lightdm = {
        enable = true;
        greeter = {
          enable = true;
        };
      };
    };
  };
}
