{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = {
    x11eventcallbacks = { enable = true; };
    polybar = { monitor = "Virtual1"; };
    bspwm = { monitor = "Virtual1"; };
    polybar = {
      enable = true;
      terminal = pkgs.wezterm;
    };
    rofi = { enable = true; };
    gtk = {
      enable = true;
      cursor = { enable = true; };
    };
    sxhkd = {
      enable = true;
      terminal = pkgs.wezterm;
    };
    bspwm = { enable = true; };
    picom = {
      enable = true;
      backend = "glx";
    };
    dunst = { enable = true; };
    betterlockscreen = { enable = true; };
    xbindkeys = { enable = true; };
  };
}
