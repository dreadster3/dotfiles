{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.kitty;
in {
  options = {
    modules.homemanager.kitty = {
      enable = mkEnableOption "kitty";
      package = mkOption {
        type = types.package;
        default = pkgs.kitty;
      };
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
      package = cfg.package;
      theme = cfg.theme;
      settings = {
        bold_font = "auto";
        bold_italic_font = "auto";
        italic_font = "VictorMono Nerd Font";
        disable_ligatures = "never";
        background_image = "${../../../wallpapers/gradient-synth-cat.png}";
        background_image_layout = "scaled";
        background_tint = "0.98";
        enabled_layouts = "tall:bias=66, grid, fat";

        window_margin_width = 10;

        map = "ctrl+shift+enter launch --cwd=current";
      };
    };
  };
}
