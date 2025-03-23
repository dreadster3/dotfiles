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

      alacritty.enable = true;
      tmux = {
        enable = true;
        extraConfig = ''
          set -g @catppuccin_window_tabs_enabled 'on'
          set -g @catppuccin_date_time "%H:%M"
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_status_modules_right "application cpu session host date_time"
        '';
      };

      # Neovim configurations add the theme
      nvim.enable = false;
    };
  };
}
