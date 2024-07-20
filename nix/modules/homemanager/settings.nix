{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.settings;

  themes = {
    catppuccin = {
      mocha = {
        base = "#1e1e2e";
        text = "#cdd6f4";
        mantle = "#181825";
        crust = "#11111b";

        overlay_0 = "#6c7086";
        overlay_1 = "#7f849c";
        overlay_2 = "#9399b2";
        subtext_0 = "#a6adc8";
        subtext_1 = "#bac2de";
        surface_0 = "#313244";
        surface_1 = "#45475a";
        surface_2 = "#585b70";

        blue = "#89b4fa";
        lavender = "#b4befe";
        sapphire = "#74c7ec";
        sky = "#89dceb";
        teal = "#94e2d5";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        peach = "#fab387";
        maroon = "#eba0ac";
        red = "#f38ba8";
        mauve = "#cba6f7";
        pink = "#f5c2e7";
        flamingo = "#f2cdcd";
        rosewater = "#f5e0dc";
        transparent = "#FF00000";
      };
    };
  };

in {
  options = {
    modules.homemanager.settings = {
      terminal = mkOption {
        type = types.package;
        default = pkgs.alacritty;
        description = "The terminal emulator to use.";
      };
      monitors = mkOption {
        type = types.attrsOf types.monitorMap;
        default = {
          x11 = { };
          wayland = { };
        };
        description = "The configuration of the monitors.";
        example = {
          x11 = {
            DP-0 = {
              primary = true;
              workspaces = [ 1 2 3 4 5 ];
            };

            HDMI-A-0 = { workspaces = [ 6 7 8 9 10 ]; };
          };
          wayland = {
            DP-0 = {
              primary = true;
              workspaces = [ 1 2 3 4 5 ];
            };

            HDMI-A-0 = { workspaces = [ 6 7 8 9 10 ]; };
          };
        };
      };
      theme = mkOption {
        type = types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              default = "catppuccin";
              description = "The name of the theme to use";
            };
            variant = mkOption {
              type = types.str;
              default = "mocha";
              description = "The variant of the theme to use";
            };
            colors = mkOption {
              type = types.attrsOf types.str;
              readOnly = true;
              description = "The colors of the theme";
            };
          };
        };
      };
    };
  };

  config = {
    modules.homemanager.settings.theme.colors =
      themes.${cfg.theme.name}.${cfg.theme.variant};
  };
}
