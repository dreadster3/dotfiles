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
    catppuccin = catppuccinConfig;

    catppuccin.gitea.enable = false;
    catppuccin.forgejo.enable = false;
    catppuccin.fcitx5.enable = false;

    home-manager.sharedModules =
      [{ modules.homemanager.catppuccin = mkDefault catppuccinConfig; }];
  };
}
