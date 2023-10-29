{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ];

  home.stateVersion = "18.09";

  home.packages = with pkgs; [ ranger killall ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Catppuccin-Mocha-Blue-Cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 32;
  };

  modules = {
    nerdfonts = { enable = true; };
    polybar = {
      enable = true;
      monitor = "Virtual1";
      terminal = pkgs.wezterm;
    };
    rofi = { enable = true; };
    gtk = { enable = true; };
    kitty = { enable = true; };
    sxhkd = {
      enable = true;
      terminal = pkgs.wezterm;
    };
    bspwm = {
      enable = true;
      monitor = "Virtual1";
    };
    btop = { enable = true; };
    picom = {
      enable = true;
      backend = "glx";
    };
    wezterm = { enable = true; };
    neovim = { enable = true; };
    ranger = { enable = true; };
    zsh = { enable = true; };
    dunst = { enable = true; };
    betterlockscreen = { enable = true; };
  };

  programs = {
    git = {
      enable = true;
      userName = "dreadster3";
      userEmail = "afonso.antunes@live.com.pt";
    };
  };
}
