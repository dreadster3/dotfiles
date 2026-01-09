{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.polkit;

  executable = {
    polkit-gnome = "polkit-gnome-authentication-agent-1";
    hyprpolkitagent = "hyprpolkitagent";
  };

  getExecutable = pkg: executable."${toString pkg.pname}";
in
{
  options = {
    modules.homemanager.polkit = {
      enable = mkEnableOption "polkit";
      package = mkOption {
        type = types.package;
        default = pkgs.polkit_gnome;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.polkit-authentication-agent-1 = {
      Unit = {
        Description = "polkit-authentication-agent-1";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${cfg.package}/libexec/${getExecutable cfg.package}";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
