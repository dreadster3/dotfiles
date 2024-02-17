{ config, lib, pkgs, ... }:
with lib;
let
  x11package = pkgs.callPackage ../../derivations/x11eventcallbacks.nix { };
  cfg = config.modules.x11eventcallbacks;
in {
  options = {
    modules.x11eventcallbacks = {
      enable = mkEnableOption "Enable x11 event callbacks";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ (x11package) ];

    systemd.user.services.x11eventcallbacks = {
      Unit = {
        Description = "X11 event callbacks";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "${x11package}/bin/x11_event_callbacks "
          + pkgs.writers.writeBash "restart_polybar.sh" ''
            bspc wm --restart
            nitrogen --restore 2> /dev/null
            pkill polybar
            MONITOR=Virtual1 polybar main &
            if type "xrandr"; then
            	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
            		if [ $m = 'Virtual1' ]; then
            			continue
            		fi
            		MONITOR=$m polybar --reload secondary &
            	done
            fi'';
        Environment = [
          "DISPLAY=:0"
          "PATH=/run/current-system/sw/bin:${pkgs.nitrogen}/bin:${pkgs.polybar}/bin"
        ];
        StandardOutput = "journal+console";
        StandardError = "journal+console";
        Restart = "always";
        RestartSec = "5";
      };
    };
  };
}
