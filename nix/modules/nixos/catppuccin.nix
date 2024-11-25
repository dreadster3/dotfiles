{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.catppuccin;
in {
  options = {
    modules.nixos.catppuccin = { enable = mkEnableOption "catppuccin"; };
  };

  config = let
    catppuccinConfig = {
      enable = true;
      flavor = "mocha";
      accent = "mauve";
    };

  in mkIf cfg.enable {
    environment.sessionVariables = {
      CATPPUCCIN_FLAVOR = catppuccinConfig.flavor;
      CATPPUCCIN_ACCENT = catppuccinConfig.accent;
    };

    catppuccin = catppuccinConfig;

    home-manager.sharedModules = [{ catppuccin = catppuccinConfig; }];
  };
}
