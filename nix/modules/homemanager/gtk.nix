{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.gtk;

in {
  options = { modules.homemanager.gtk = { enable = mkEnableOption "gtk"; }; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ dconf lxappearance ];

    gtk = {
      enable = true;
      catppuccin.icon = {
        enable = config.gtk.catppuccin.enable;
        flavor = config.catppuccin.flavor;
        accent = config.catppuccin.accent;
      };
    };
  };
}
