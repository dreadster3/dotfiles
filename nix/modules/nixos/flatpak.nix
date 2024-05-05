{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.flatpak;
in {
  options = { modules.nixos.flatpak = { enable = mkEnableOption "flatpak"; }; };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
}
