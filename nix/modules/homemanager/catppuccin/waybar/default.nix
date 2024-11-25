{ pkgs, lib, config, ... }:
with lib;
let cfg = config.catppuccin;
in {
  options = { };

  config = mkIf cfg.enable {
    programs.waybar.style = toString (import ./style.nix { config = cfg; });
  };
}
