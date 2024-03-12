{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.wezterm;
in {
  options = {
    modules.homemanager.wezterm = { enable = mkEnableOption "wezterm"; };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wezterm ];

    xdg.configFile.wezterm = {
      source = ../../../configurations/wezterm;
      recursive = true;
    };
  };
}
