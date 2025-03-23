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

    home-manager.sharedModules = [{
      modules.homemanager = {
        hyprland.enable = mkDefault true;
        rofi.enable = mkDefault true;
        rofi.package = mkDefault pkgs.rofi-wayland;
        waybar.enable = mkDefault true;
        wlogout.enable = mkDefault true;
        hypridle.enable = mkDefault true;
        hyprlock.enable = mkDefault true;
        hyprpaper.enable = mkDefault true;
      };
    }];
  };
}
