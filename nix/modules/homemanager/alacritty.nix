{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.alacritty;
  colors = config.modules.homemanager.settings.theme.colors;

  base = colors.base;
  text = colors.text;
  overlay_1 = colors.overlay_1;
  subtext_0 = colors.subtext_0;
  subtext_1 = colors.subtext_1;
  surface_1 = colors.surface_1;
  surface_2 = colors.surface_2;

  red = colors.red;
  green = colors.green;
  yellow = colors.yellow;
  blue = colors.blue;
  pink = colors.pink;
  teal = colors.teal;
  rosewater = colors.rosewater;
  lavender = colors.lavender;
  peach = colors.peach;

in {
  options = {
    modules.homemanager.alacritty = {
      enable = mkEnableOption "alacritty";
      font = mkOption {
        description = "Font to use for kitty";
        default = { };
        type = types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              default = "FiraCode Nerd Font";
              description = "Name of font";
            };
            size = mkOption {
              type = types.int;
              default = 18;
              description = "Size of font";
            };
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = cfg.font.size;
          normal = { family = cfg.font.name; };
          italic = { family = "VictorMono Nerd Font"; };
        };

        window = {
          padding = {
            x = 20;
            y = 20;
          };
        };

        keyboard.bindings = [{
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }];

        colors = {
          primary = {
            background = base;
            foreground = text;
            dim_foreground = overlay_1;
            bright_foreground = text;
          };
          cursor = {
            text = base;
            cursor = rosewater;
          };
          vi_mode_cursor = {
            text = base;
            cursor = lavender;
          };
          search = {
            matches = {
              foreground = base;
              background = subtext_0;
            };
            focused_match = {
              foreground = base;
              background = green;
            };
          };
          footer_bar = {
            foreground = base;
            background = subtext_0;
          };
          hints = {
            start = {
              foreground = base;
              background = yellow;
            };
            end = {
              foreground = base;
              background = subtext_0;
            };
          };
          selection = {
            foreground = base;
            background = rosewater;
          };
          normal = {
            black = surface_1;
            red = red;
            green = green;
            yellow = yellow;
            blue = blue;
            magenta = pink;
            cyan = teal;
            white = subtext_1;
          };
          bright = {
            black = surface_2;
            red = red;
            green = green;
            yellow = yellow;
            blue = blue;
            magenta = pink;
            cyan = teal;
            white = subtext_0;
          };
          dim = {
            black = surface_1;
            red = red;
            green = green;
            yellow = yellow;
            blue = blue;
            magenta = pink;
            cyan = teal;
            white = subtext_1;
          };
          indexed_colors = [
            {
              index = 16;
              color = peach;
            }
            {
              index = 17;
              color = rosewater;
            }
          ];
        };
      };
    };
  };
}
