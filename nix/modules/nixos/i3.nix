{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.i3;
in {
  options = { modules.nixos.i3 = { enable = mkEnableOption "i3"; }; };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.xserver.enable;
      message = "xserver must be enabled to use bspwm";
    }];

    services.xserver = { windowManager.i3.enable = true; };

    services.displayManager = { defaultSession = "none+i3"; };

    home-manager.sharedModules = [{
      xsession.windowManager.i3 = {
        enable = true;
        package = pkgs.i3-rounded;
        config = {
          keybinds = let modifier = config.xsession.windowManager.i3.modifier;
          in lib.mkOptionDefault { "${modifier}+w" = "kill"; };
          modifier = "Mod4";
          terminal = "alacritty";
          gaps = {
            inner = 10;
            outer = 5;
          };
        };
      };
    }];
  };
}
