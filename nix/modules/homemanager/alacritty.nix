{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.alacritty;
  settings = config.modules.homemanager.settings;
in {
  options = {
    modules.homemanager.alacritty = {
      enable = mkEnableOption "alacritty";
      package = mkOption {
        type = types.package;
        default = pkgs.alacritty;
      };
      yaml = mkEnableOption "alacritty.yaml";
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = cfg.package;
      catppuccin.enable = true;
      settings = {
        font = {
          size = settings.font.size;
          normal = settings.font.normal;
          italic = settings.font.italic;
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
