{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.nerdfonts;
in
{
	config = {
		home-manager.users = {
			"${username}" = {pkgs, ...}: {
				fonts.fontconfig.enable = true;

				home.packages = with pkgs; [
					(nerdfonts.override { fonts = [ "FiraCode" "VictorMono" "Iosevka" ]; })
				];
			};
		};
	};
}
