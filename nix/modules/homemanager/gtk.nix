{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.gtk;

in {
  options = { modules.homemanager.gtk = { enable = mkEnableOption "gtk"; }; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ lxappearance ];

    gtk = {
      enable = true;

      gtk2.extraConfig = ''
        gtk-application-prefer-dark-theme = true
      '';
      gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
      gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };

      catppuccin.icon = {
        enable = config.catppuccin.enable;
        flavor = config.catppuccin.flavor;
        accent = config.catppuccin.accent;
      };
    };
  };
}
