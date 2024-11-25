{ pkgs, lib, config, ... }:
with lib;
let cfg = config.programs.waybar.catppuccin;
in {
  options = { };

  config = mkIf cfg.enable {
    programs.waybar.style =
      concatStringsSep "\n" (import ./style.css { accent = cfg.accent; });
  };
}
