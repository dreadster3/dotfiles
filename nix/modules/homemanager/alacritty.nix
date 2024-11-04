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
      package = mkOption {
        type = types.package;
        default = pkgs.alacritty;
      };
      yaml = mkEnableOption "alacritty.yaml";
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
      package = cfg.package;
      settings = {
        font = {
          normal = { style = lib.mkForce "Bold"; };
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
      };
    };

    xdg.configFile."alacritty/alacritty.yml" =
      mkIf (config.programs.alacritty.settings != { } && cfg.yaml) {
        text = replaceStrings [ "\\\\" ] [ "\\" ]
          (builtins.toJSON config.programs.alacritty.settings);
      };
  };
}
