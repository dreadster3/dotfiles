{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.catppuccin;
in {
  imports = [
    ./hyprland.nix
    ./waybar
    ./rofi.nix
    ./colors.nix
    ./bspwm.nix
    ./dunst.nix
    ./tmux.nix
  ];

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

    home.pointerCursor.gtk.enable = true;

    catppuccin = {
      enable = true;
      inherit (cfg) flavor accent;

      alacritty.enable = true;
      cursors.enable = true;
      kvantum.enable = true;
      lazygit.enable = true;
      tmux.enable = true;
      rofi.enable = true;

      # Neovim configurations add the theme
      nvim.enable = false;
    };
  };
}
