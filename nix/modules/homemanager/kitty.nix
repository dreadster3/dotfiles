{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.kitty;
in {
  options = {
    modules.kitty = {
      enable = mkEnableOption "kitty";
      theme = mkOption {
        type = types.str;
        default = "Catppuccin-Mocha";
        description = "	Theme to use for kitty\n";
      };
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
    programs.kitty = {
      enable = true;
      theme = cfg.theme;
      font = {
        name = cfg.font.name;
        size = cfg.font.size;
      };
      settings = {
        bold_font = "auto";
        bold_italic_font = "auto";
        italic_font = "VictorMono Nerd Font";
        disable_ligatures = "never";
        background_image =
          "~/Documents/projects/github/dotfiles/wallpapers/gradient-synth-cat.png";
        background_image_layout = "scaled";
        background_tint = "0.98";
        enabled_layouts = "tall:bias=66, grid, fat";

        map = "ctrl+shift+enter launch --cwd=current";
      };
    };
  };
}
