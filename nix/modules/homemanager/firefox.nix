{ pkgs, name, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.firefox;
in {
  options = {
    modules.homemanager.firefox = {
      enable = mkEnableOption "firefox";
      package = mkOption {
        type = types.package;
        default = pkgs.firefox-devedition;
      };
    };
  };

  config = mkIf cfg.enable { home.packages = [ cfg.package ]; };
}
