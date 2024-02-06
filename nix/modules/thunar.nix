{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.thunar;
in {
  options = { modules.thunar = { enable = mkEnableOption "thunar"; }; };

  config = mkIf cfg.enable {
    programs = { thunar.enable = true; };
    services = { tumbler.enable = true; };
  };
}
