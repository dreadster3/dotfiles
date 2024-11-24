{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.gtk;

in
{
  options = { modules.homemanager.gtk = { enable = mkEnableOption "gtk"; }; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ dconf lxappearance ];

    gtk = {
      enable = true;
      catppuccin.icon = {
        enable = true;
        flavor = config.catppuccin.flavor;
        accent = config.catppuccin.accent;
      };
      # iconTheme = {
      #   name = "candy-icons";
      #   package = pkgs.candy-icons;
      # };
    };
  };
}
