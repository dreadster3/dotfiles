{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.rofi;
in
{
	config = {
		home.packages = with pkgs; [
			rofi
		];
	};
}
