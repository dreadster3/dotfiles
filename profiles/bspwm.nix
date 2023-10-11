{ config, pkgs, lib, ...}:

{
  services = {
    picom = {
      enable = true;
    };
  };

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
