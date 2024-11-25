{ pkgs, lib, config, ... }:
with lib;
let
  inherit (config.lib.formats.rasi) mkLiteral;
  cfg = config.programs.rofi.catppuccin;
  accent = mkLiteral "@${config.catppuccin.accent}";
in {
  options = { };

  config = mkIf cfg.enable {
    programs.rofi = {
      theme = {
        "*" = mapAttrs (n: v: mkLiteral v) config.catppuccin.colors;
        prompt.background-color = accent;
        window.border-color = accent;
      };

    };
  };
}
