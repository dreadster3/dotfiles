{config, lib, pkgs, ...}:
{
	config = {
		home.packages = with pkgs; [
			dconf
		];
		gtk = {
			enable = true;
			theme = {
				package = pkgs.catppuccin-gtk.override {
					accents = ["blue"];
					variant = "mocha";
				};
				name = "Catppuccin-Mocha-Standard-Blue-Dark";
			};
		};
	};
}
