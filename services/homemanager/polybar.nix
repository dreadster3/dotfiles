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
				script = builtins.readFile ../../configurations/polybar/shades/launch.sh;
			};
		};

		systemd.user.services.polybar = {
			Install.WantedBy = ["graphical-session.target"];
		};
	};
}
