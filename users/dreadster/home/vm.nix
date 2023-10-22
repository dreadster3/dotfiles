{config, lib, pkgs, ...}:
let
	x11package = pkgs.callPackage ../../../derivations/x11eventcallbacks.nix {};
in
{
	imports = [
		./default.nix
	];

	home.packages = with pkgs; [
		(x11package)
	];

	systemd.user.services.x11eventcallbacks = {
		Unit = {
			Description = "X11 event callbacks";
			After = [ "graphical.target" ];
		};

		Install = {
			WantedBy = [ "default.target" ];
		};

		Service = {
			ExecStart = "${x11package}/bin/x11_event_callbacks " + pkgs.writers.writeBash "restart_polybar.sh" ''
				nitrogen --restore 2> /dev/null
				$HOME/.config/polybar/shades/launch.sh & disown
			'';
			Environment = [
				"DISPLAY=:0"
				"PATH=/run/current-system/sw/bin:${pkgs.killall}/bin:${pkgs.polybar}/bin"
			];
			StandardOutput = "journal+console";
			StandardError = "journal+console";
			Restart = "always";
			RestartSec = "5";
		};
	};
}
