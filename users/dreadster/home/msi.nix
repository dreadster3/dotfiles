{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = {
    x11eventcallbacks = { enable = true; };
    polybar = {
      monitor = "eDP-1-1";
      networkInterface = {
        name = "wlo1";
        type = "wireless";
      };
      useBattery = true;
    };
    bspwm = { monitor = "eDP-1-1"; };
    fusuma = { enable = true; };
  };
}
