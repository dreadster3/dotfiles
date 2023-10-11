{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.polybar;
in
{
	config = {
		home-manager.users = {
			"${username}" = {pkgs, ...}: {
				services = {
					polybar = {
						enable = true;
						script = "echo 1";
					};
				};
			};
		};
	};
}
