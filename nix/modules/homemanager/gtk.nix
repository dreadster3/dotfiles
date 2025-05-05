{ config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.gtk;

in {
  options = { modules.homemanager.gtk = { enable = mkEnableOption "gtk"; }; };
  config = mkIf cfg.enable {
    gtk = {
      enable = true;

      gtk2.extraConfig = ''
        gtk-application-prefer-dark-theme = true
      '';
      gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
      gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };

      catppuccin.icon = { inherit (config.catppuccin) enable flavor accent; };
    };
  };
}
