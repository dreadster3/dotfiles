{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.gtk;
  capitalize = str:
    concatImapStrings (pos: x: if pos == 1 then (toUpper x) else x)
    (stringToCharacters str);

in {
  options = {
    modules.homemanager.gtk = {
      enable = mkEnableOption "gtk";
      variant = mkOption {
        type = types.str;
        default = "mocha";
        description = "	Variant for GTK catppuccin theme.\n";
      };
      accent = mkOption {
        type = types.str;
        default = "blue";
        description = "	Accent color for GTK catppuccin theme.\n";
      };
      cursor = mkOption {
        default = { };
        type = types.submodule {
          options = { enable = mkEnableOption "gtk.cursor"; };
        };
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ dconf lxappearance ];

    home.pointerCursor = mkIf cfg.cursor.enable {
      gtk.enable = true;
      x11.enable = true;
      name =
        "Catppuccin-${capitalize cfg.variant}-${capitalize cfg.accent}-Cursors";
      package =
        pkgs.catppuccin-cursors."${cfg.variant}${capitalize cfg.accent}";
      size = 32;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.catppuccin-gtk.override {
          accents = [ cfg.accent ];
          variant = cfg.variant;
        };
        name = "Catppuccin-${capitalize cfg.variant}-Standard-${
            capitalize cfg.accent
          }-Dark";
      };
    };
  };
}
