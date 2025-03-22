{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.xfce;
in {
  options = {
    modules.nixos.xfce = {
      enable = mkEnableOption "xfce";
      windowManager = mkOption {
        type =
          types.submodule { options = { enable = mkEnableOption "xfce"; }; };
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.xserver.enable;
      message = "xserver must be enabled to use xfce";
    }];

    services.xserver.desktopManager.xfce = {
      enable = true;
      noDesktop = !cfg.windowManager.enable;
      enableXfwm = cfg.windowManager.enable;
    };
  };
}
