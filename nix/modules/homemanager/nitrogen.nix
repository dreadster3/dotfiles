{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.nitrogen;
in {
  options = {
    modules.homemanager.nitrogen = {
      enable = mkEnableOption "nitrogen";
      package = mkOption {
        type = types.package;
        default = pkgs.nitrogen;
        description = "X11 wallpaper manager";
      };
    };
  };
  config = mkIf cfg.enable {
    xsession.windowManager.bspwm.startupPrograms =
      [ "${getExe pkgs.nitrogen} --restore" ];

    xsession.windowManager.i3.config.startup = [{
      command = "${getExe pkgs.nitrogen} --restore";
      always = true;
      notification = false;
    }];

    home.packages = [ cfg.package ];
  };
}
