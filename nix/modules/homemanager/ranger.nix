{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.ranger;
in {
  options = { modules.ranger = { enable = mkEnableOption "ranger"; }; };
  config = mkIf cfg.enable {
    xdg = {
      configFile = {
        ranger = {
          source = ../../../configurations/ranger;
          recursive = true;
        };
      };
    };
  };
}
