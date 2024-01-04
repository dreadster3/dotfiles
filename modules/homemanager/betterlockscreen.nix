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
  };
}
