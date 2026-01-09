{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.guake;
in
{
  options = {
    modules.homemanager.guake = {
      enable = mkEnableOption "guake";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ guake ];

    systemd.user.services.guake = {
      Unit = {
        Description = "guake";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.guake}/bin/guake";
        Environment = [ "DISPLAY=:0" ];
        StandardOutput = "journal+console";
        StandardError = "journal+console";
        Restart = "always";
        RestartSec = "5";
      };
    };
  };
}
