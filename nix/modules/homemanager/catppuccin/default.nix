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

    programs.tmux.plugins = with pkgs.tmuxPlugins; [{
      plugin = cpu;
      extraConfig = ''
        set -g status-right "#{E:@catppuccin_status_host}"
        set -ag status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
      '';
    }];

    catppuccin = {
      enable = true;
      flavor = cfg.flavor;
      accent = cfg.accent;

      alacritty.enable = true;
      rofi.enable = true;
      kvantum.enable = true;
      tmux = {
        enable = true;
        extraConfig = ''
          set -g @catppuccin_window_text " #W"
          set -g @catppuccin_window_number "#I"
          set -g @catppuccin_window_current_number "#F"
          set -g @catppuccin_window_status_style "rounded"
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
        '';
      };

      # Neovim configurations add the theme
      nvim.enable = false;
    };
  };
}
