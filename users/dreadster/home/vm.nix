{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = {
    x11eventcallbacks = { enable = true; };
    polybar = { monitor = "Virtual1"; };
    bspwm = { monitor = "Virtual1"; };
  };
}
