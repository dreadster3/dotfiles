{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.gtk;

in {
  options = { modules.homemanager.gtk = { enable = mkEnableOption "gtk"; }; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ dconf lxappearance ];

    gtk = {
      enable = true;
      iconTheme = {
        name = "candy-icons";
        package = pkgs.candy-icons;
      };
    };
  };
}
