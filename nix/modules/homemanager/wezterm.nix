{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.wezterm;
in {
  options = { modules.wezterm = { enable = mkEnableOption "wezterm"; }; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wezterm ];

    xdg.configFile.wezterm = {
      source = ../../../configurations/wezterm;
      recursive = true;
    };
  };
}
