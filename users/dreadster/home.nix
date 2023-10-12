{config, lib, pkgs, ...}:
{
	imports = [
		../../services/homemanager/neovim.nix
		../../services/homemanager/zsh.nix
		../../services/homemanager/rofi.nix
		../../services/homemanager/polybar.nix
		../../services/homemanager/nerdfonts.nix
		../../services/homemanager/gtk.nix
	];

	home.stateVersion = "18.09";

	home.packages = with pkgs; [
		ranger
	];

	home.pointerCursor = {
		gtk.enable = true;
		x11.enable = true;
		name = "Catppuccin-Mocha-Blue-Cursors";
		package = pkgs.catppuccin-cursors.mochaBlue;
		size = 32;
	};

	xdg = {
		configFile = {
			bspwm = {
				source = ../../configurations/bspwm;
				recursive = true;
			};
			picom = {
				source = ../../configurations/picom;
				recursive = true;
			};
			sxhkd = {
				source = ../../configurations/sxhkd;
				recursive = true;
			};
			polybar = {
				source = ../../configurations/polybar;
				recursive = true;
			};
			rofi = {
				source = ../../configurations/rofi;
				recursive = true;
			};
			kitty = {
				source = ../../configurations/kitty;
				recursive = true;
			};
			btop = {
				source = ../../configurations/btop;
				recursive = true;
			};
			ranger = {
				source = ../../configurations/ranger;
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
