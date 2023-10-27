{ config, lib, pkgs, username, ... }:
with lib;
let cfg = config.modules.rofi;
in {
  options = {
    modules.rofi = {
      enable = mkEnableOption "rofi";
      font = mkOption {
        type = types.str;
        default = "Fira Code Nerd Font 12";
        description = "Font to use for rofi";
      };
      terminal = mkOption {
        type = types.package;
        default = pkgs.kitty;
        description = "Terminal to use for rofi";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      cycle = true;
      font = cfg.font;
      plugins = [ pkgs.rofi-power-menu ];
      terminal = lib.getExe cfg.terminal;
      location = "center";
      theme = ./theme.rasi;
      extraConfig = {
        modi = "drun";
        show-icons = true;
        display-drun = "";
        drun-display-format = "{name}";
      };
    };

    xdg.configFile."rofi/powermenu.rasi" = { source = ./powermenu.rasi; };
  };
}
