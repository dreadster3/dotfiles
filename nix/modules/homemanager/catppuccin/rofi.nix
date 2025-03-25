{ pkgs, lib, config, ... }:
with lib;
let
  inherit (config.lib.formats.rasi) mkLiteral;
  cfg = config.catppuccin.rofi;
  accent = mkLiteral "@${config.catppuccin.accent}";
in {
  options = { };

  config = mkIf cfg.enable {
    programs.rofi = {
      theme = {
        "*" = mapAttrs (n: v: mkLiteral v) config.catppuccin.colors;
        prompt.text-color = mkForce accent;
        window.border-color = mkForce accent;
        "element selected.normal".background-color = mkForce accent;
      };
    };
  };
}
