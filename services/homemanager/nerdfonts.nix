{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.nerdfonts;
in
{
	config = {
		fonts.fontconfig.enable = true;

		home.packages = with pkgs; [
			(nerdfonts.override { fonts = [ "FiraCode" "VictorMono" "Iosevka" ]; })
		];
	};
}
