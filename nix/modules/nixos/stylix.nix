{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.nixos.stylix;
  catppuccinConfig = config.catppuccin;
  mkUpper = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {
  options = { modules.nixos.stylix = { enable = mkEnableOption "stylix"; }; };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ../../../wallpapers/furina.jpg;
      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      fonts = {
        monospace = {
          name = "Mononoki Nerd Font";
          package = pkgs.nerd-fonts.mononoki;
        };

        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;

        sizes = {
          terminal = 18;
          desktop = 12;
        };
      };

      # Disable modules supported by catppuccin
      targets = {
        grub.enable = false;
        qt.enable = false;
      };
    };

    home-manager.sharedModules =
      [{ modules.homemanager.stylix.enable = mkDefault true; }];
  };
}
