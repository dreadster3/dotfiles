{ pkgs, lib, config, ... }:
with lib;
let
  catppuccin = config.catppuccin;
  settings = config.modules.homemanager.settings;
in {
  options = { };

  config = mkIf catppuccin.enable {
    programs.waybar.style =
      toString (import ./style.nix { inherit catppuccin settings; });
  };
}
