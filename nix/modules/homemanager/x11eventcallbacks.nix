{ config, lib, pkgs, ... }:
with lib;
let
  x11package = pkgs.callPackage ../../derivations/x11eventcallbacks.nix { };
  cfg = config.modules.x11eventcallbacks;
in
{
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
          + pkgs.writers.writeBash "restart_polybar.sh"
          "	nitrogen --restore 2> /dev/null\n	systemctl --user restart polybar\n";
        Environment = [
          "DISPLAY=:0"
          "PATH=/run/current-system/sw/bin:${pkgs.nitrogen}/bin"
        ];
        StandardOutput = "journal+console";
        StandardError = "journal+console";
        Restart = "always";
        RestartSec = "5";
      };
    };
  };
}
