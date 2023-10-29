{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.betterlockscreen;
in {
  options = {
    modules.betterlockscreen = { enable = mkEnableOption "betterlockscreen"; };
  };

  config = mkIf cfg.enable {
    services.betterlockscreen = {
      enable = true;
      arguments = [ "blur" ];
    };
  };
}
