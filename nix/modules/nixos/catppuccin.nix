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
      accent = "blue";
    };

  in mkIf cfg.enable {
    catppuccin = catppuccinConfig;

    home-manager.sharedModules = [{ catppuccin = catppuccinConfig; }];
  };
}
