{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.x11eventcallbacks;
in {
  options = {
    modules.homemanager.x11eventcallbacks = {
      enable = mkEnableOption "Enable x11 event callbacks";
      package = mkOption {
        type = types.package;
        default = pkgs.x11eventcallbacks;
        description = "The package to use for x11 event callbacks";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ cfg.package ];

    systemd.user.services.x11eventcallbacks = {
      Unit = {
        Description = "X11 event callbacks";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "${cfg.package}/bin/x11_event_callbacks "
          + pkgs.writers.writeBash "restart_polybar.sh" ''
            bspc wm --restart
            nitrogen --restore 2> /dev/null
            pkill polybar
            ${config.modules.homemanager.polybar.script}
          '';
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
