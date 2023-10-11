{config, lib, pkgs, ...}:
{
	imports = [
		../../services/neovim.nix
		../../services/zsh-plugins.nix
		../../services/rofi.nix
		../../services/polybar.nix
		../../services/nerdfonts.nix
	];

	home.stateVersion = "18.09";

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
