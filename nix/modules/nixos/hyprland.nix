{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.hyprland;
in {
  options = {
    modules.nixos.hyprland = { enable = mkEnableOption "Hyprland"; };
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
