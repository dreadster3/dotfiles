{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nixos.nightlight;
in {
  options = {
    modules.nixos.nightlight = { enable = mkEnableOption "nightlight"; };
  };
  config = mkIf cfg.enable {
    home-manager.sharedModules =
      [{ modules.homemanager = { gammastep.enable = true; }; }];
  };
}
