{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.betterlockscreen;
in {
  options = {
    modules.homemanager.betterlockscreen = {
      enable = mkEnableOption "betterlockscreen";
      package = mkOption {
        type = with pkgs; types.package;
        default = pkgs.betterlockscreen;
        description = "The package to use for betterlockscreen";
      };
      arguments = mkOption {
        type = types.listOf types.str;
        default = [ "blur" ];
        description = "Arguments to pass to betterlockscreen";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ feh ];

    services.betterlockscreen = {
      enable = true;
      package = cfg.package;
      arguments = cfg.arguments;
    };

    # Disable xautolock, to use xidlehook instead
    services.screen-locker.xautolock.enable = false;
  };
}
