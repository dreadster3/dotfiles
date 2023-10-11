{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.polybar;
in
{
	config = {
		services = {
			polybar = {
				enable = true;
				script = "echo 1";
			};
		};
	};
}
