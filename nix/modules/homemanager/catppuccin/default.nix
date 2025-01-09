{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.catppuccin;
in {
  imports =
    [ ./hyprland.nix ./waybar ./rofi.nix ./colors.nix ./bspwm.nix ./dunst.nix ];

  options = {
    modules.homemanager.catppuccin = {
      enable = mkEnableOption "catppuccin";
      flavor = mkOption {
        type = types.str;
        default = "mocha";
      };
      accent = mkOption {
        type = types.str;
        default = "blue";
      };
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      CATPPUCCIN_FLAVOR = cfg.flavor;
      CATPPUCCIN_ACCENT = cfg.accent;
    };

    catppuccin = {
      enable = true;
      flavor = cfg.flavor;
      accent = cfg.accent;

      nvim.enable = false;
      alacritty.enable = true;
      tmux.enable = false;
    };
  };
}
