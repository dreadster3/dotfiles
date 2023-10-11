{config, lib, pkgs, ...}:

{
	imports = [
		(import ../../services/neovim.nix { inherit config pkgs lib; username = "dreadster"; })
		(import ../../services/zsh-plugins.nix { inherit config pkgs lib; username = "dreadster"; })
		(import ../../services/nerdfonts.nix { inherit config pkgs lib; username = "dreadster"; })
		(import ../../services/polybar.nix { inherit config pkgs lib; username = "dreadster"; })
		(import ../../services/rofi.nix { inherit config pkgs lib; username = "dreadster"; })
	];

	users.users.dreadster = {
		shell = pkgs.zsh;
		isNormalUser = true;
		description = "Admin";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	# customservices = {
	# 	neovim = {
	# 		enable = true;
	# 		user = "dreadster";
	# 	};
	# 	zshplugins = {
	# 		enable = true;
	# 		user = "dreadster";
	# 	};
	# 	# nerdfonts = {
	# 	# 	enable = true;
	# 	# 	user = "dreadster";
	# 	# };
	# 	polybar = {
	# 		enable = true;
	# 		user = "dreadster";
	# 	};
	# 	rofi = {
	# 		enable = true;
	# 		user = "dreadster";
	# 	};
	# };

	home-manager.users.dreadster = {pkgs, ...}: {
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
	};
}
