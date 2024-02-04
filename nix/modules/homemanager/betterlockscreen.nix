{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.betterlockscreen;
in {
  options = {
    modules.betterlockscreen = { enable = mkEnableOption "betterlockscreen"; };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ feh ];

    services.betterlockscreen = {
      enable = true;
      arguments = [ "blur" ];
    };

    # Disable xautolock, to use xidlehook instead
    services.screen-locker.xautolock.enable = false;
  };
}
