{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.flatpak;
in {
  options = { modules.nixos.flatpak = { enable = mkEnableOption "flatpak"; }; };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    xdg = {
      mime.enable = true;
      menus.enable = true;
      icons.enable = true;
      sounds.enable = true;
      portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        config.common.default = "*";
      };
    };
  };
}
