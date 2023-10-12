{config, lib, pkgs, ...}:
{
	imports = [
		../../services/homemanager/neovim.nix
		../../services/homemanager/zsh.nix
		../../services/homemanager/nerdfonts.nix
	];

	home.stateVersion = "18.09";

	home.packages = with pkgs; [
		ranger
		btop
	];

	xdg = {
		configFile = {
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
