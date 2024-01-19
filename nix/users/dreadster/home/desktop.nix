{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = {
    waybar = { enable = true; };
    wofi = { enable = true; };
    hyprland = { enable = true; };
    gtk = {
      enable = true;
      cursor = { enable = true; };
    };
    # guake = { enable = true; };
    dunst = { enable = true; };
    polybar = {
      enable = true;
      terminal = pkgs.wezterm;
    };
    rofi = { enable = true; };
    sxhkd = {
      enable = true;
      terminal = pkgs.wezterm;
    };
    bspwm = { enable = true; };
    picom = { enable = true; };
  };
}
