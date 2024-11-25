{ pkgs, lib, config, ... }:
with lib;
let
  inherit (config.lib.formats.rasi) mkLiteral;
  cfg = config.programs.rofi.catppuccin;

  colors = {
    mocha = {
      rosewater = mkLiteral "#f5e0dc";
      flamingo = mkLiteral "#f2cdcd";
      pink = mkLiteral "#f5c2e7";
      mauve = mkLiteral "#cba6f7";
      red = mkLiteral "#f38ba8";
      maroon = mkLiteral "#eba0ac";
      peach = mkLiteral "#fab387";
      yellow = mkLiteral "#f9e2af";
      green = mkLiteral "#a6e3a1";
      teal = mkLiteral "#94e2d5";
      sky = mkLiteral "#89dceb";
      sapphire = mkLiteral "#74c7ec";
      blue = mkLiteral "#89b4fa";
      lavender = mkLiteral "#b4befe";
      text = mkLiteral "#cdd6f4";
      subtext1 = mkLiteral "#bac2de";
      subtext0 = mkLiteral "#a6adc8";
      overlay2 = mkLiteral "#9399b2";
      overlay1 = mkLiteral "#7f849c";
      overlay0 = mkLiteral "#6c7086";
      surface2 = mkLiteral "#585b70";
      surface1 = mkLiteral "#45475a";
      surface0 = mkLiteral "#313244";
      base = mkLiteral "#1e1e2e";
      mantle = mkLiteral "#181825";
      crust = mkLiteral "#11111b";
    };
  };
  accent = mkLiteral "@${config.catppuccin.accent}";
in {
  options = { };

  config = mkIf cfg.enable {
    programs.rofi = {
      theme = {
        "*" = colors."${config.catppuccin.flavor}";
        prompt.background-color = accent;
        window.border-color = accent;
      };

    };
  };
}
