{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.thunar;
in {
  options = { modules.nixos.thunar = { enable = mkEnableOption "thunar"; }; };

  config = mkIf cfg.enable {
    programs = { thunar.enable = true; };
    services = { tumbler.enable = true; };
  };
}
