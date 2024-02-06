{ config, lib, pkgs, ... }:
let primaryMonitor = "Virtual1";
in {
  imports = [ ./default.nix ];

  modules = {
    x11eventcallbacks = { enable = true; };
    polybar = {
      enable = true;
      monitor = primaryMonitor;
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
      monitor = primaryMonitor;
      startupPrograms = [ "vmware-user" ];
    };
    picom = { enable = false; };
    dunst = { enable = true; };
    betterlockscreen = { enable = true; };
  };
}
