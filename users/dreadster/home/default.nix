{ config, lib, pkgs, ... }:
{
  imports = [
    ../../../modules/homemanager
  ];

  home.stateVersion = "18.09";

  home.packages = with pkgs; [
    ranger
    killall
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Catppuccin-Mocha-Blue-Cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 32;
  };

  modules = {
    nerdfonts = {
      enable = true;
    };
    polybar = {
      enable = true;
      monitor = "Virtual1";
    };
    rofi = {
      enable = true;
    };
    gtk = {
      enable = true;
    };
	kitty = {
		enable = true;
	};
	x11eventcallbacks = {
		enable = true;
	};
	sxhkd = {
		enable = true;
	};
  };

  xdg = {
    configFile = {
      bspwm = {
        source = ../../../configurations/bspwm;
        recursive = true;
      };
      picom = {
        source = ../../../configurations/picom;
        recursive = true;
      };
      btop = {
        source = ../../../configurations/btop;
        recursive = true;
      };
      ranger = {
        source = ../../../configurations/ranger;
        recursive = true;
      };
    };
  };

  programs = {
    git = {
      enable = true;
      userName = "dreadster3";
      userEmail = "afonso.antunes@live.com.pt";
    };
  };
}
