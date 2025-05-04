{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.hyprlock;
in {
  options = {
    modules.homemanager.hyprlock = {
      enable = mkEnableOption "hyprlock";
      package = mkOption {
        type = types.package;
        default = pkgs.hyprlock;
        description = "The hyprlock package to use";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "hyprlock requires the hyprland window manager to be enabled";
      }
      {
        assertion = !config.programs.swaylock.enable;
        message = "hyprlock is incompatible with swaylock";
      }
    ];

    wayland.windowManager.hyprland.settings.bind =
      [ "$mainMod_CTRL, Q, exec, ${cfg.package}/bin/hyprlock" ];

    programs.hyprlock = {
      enable = true;
      inherit (cfg) package;
      settings = {
        background =
          [{ path = toString ../../../wallpapers/ctp_line_mocha_mauve.jpg; }];
      };
    };

    systemd.user.services.hyprlock-suspend = {
      Unit = {
        Description = "Lock screen on suspend";
        After = [ "sleep.target" ];
      };
      Service = {
        Type = "forking";
        Environment = "DISPLAY=:0";
        ExecStart = "${cfg.package}/bin/hyprlock";
      };
      Install = { WantedBy = [ "sleep.target" ]; };
    };
  };
}
