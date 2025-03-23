{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.homemanager.i3;
in {
  options = {
    modules.homemanager.i3 = {
      enable = mkEnableOption "i3";
      package = mkOption {
        type = types.package;
        default = pkgs.i3;
      };
    };
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = cfg.package;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        bars = [ ];

        keybindings =
          let modifier = config.xsession.windowManager.i3.config.modifier;
          in mkOptionDefault { "${modifier}+w" = "kill"; };

        gaps = {
          inner = 10;
          outer = 5;
        };
      };
    };
  };
}
