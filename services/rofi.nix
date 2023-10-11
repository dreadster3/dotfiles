{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.rofi;
in
{
	config = {
		home-manager.users = {
			"${username}" = {pkgs, ...}: {
				home.packages = with pkgs; [
					rofi
				];
			};
		};
	};
}
