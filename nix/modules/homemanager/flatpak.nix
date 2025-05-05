{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.flatpak;
in {
  options = {
    modules.homemanager.flatpak = { enable = mkEnableOption "flatpak"; };
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config = {
        common = {
          default = [ "hyprland" "gtk" ];
          "org.freedesktop.portal.OpenURI" = [ "gtk" ];
        };
      };
    };
  };
}
