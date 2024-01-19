{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = {
    x11eventcallbacks = { enable = true; };
    polybar = {
      enable = true;
      terminal = pkgs.wezterm;
      monitor = "Virtual1";
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
    bspwm = {
      enable = true;
      monitor = "Virtual1";
    };
    picom = {
      enable = true;
      backend = "glx";
    };
    dunst = { enable = true; };
    betterlockscreen = { enable = true; };
    xbindkeys = { enable = true; };
  };
}
