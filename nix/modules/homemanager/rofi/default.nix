{ config, lib, pkgs, username, ... }:
with lib;
let
  cfg = config.modules.homemanager.rofi;
  packagePath = getExe config.programs.rofi.finalPackage;
  terminal = either cfg.terminal config.modules.homemanager.settings.terminal;
in {
  options = {
    modules.homemanager.rofi = {
      enable = mkEnableOption "rofi";
      package = mkOption {
        type = types.package;
        default = pkgs.rofi;
        description = "Package to use for rofi";
      };
      font = mkOption {
        type = types.str;
        default = "Fira Code Nerd Font 12";
        description = "Font to use for rofi";
      };
      terminal = mkOption {
        type = types.nullOr types.package;
        default = null;
        description = "Terminal to use for rofi";
      };
      powermenu = mkOption {
        description = "Powermenu configuration";
        default = { };
        type = types.submodule {
          options = {
            enable = mkEnableOption "rofi.powermenu";
            package = mkOption {
              type = types.package;
              default = pkgs.rofi-power-menu;
              description = "Package to use for rofi-power-menu";
            };
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.sxhkd.keybindings = {
      "super + @space" = "${packagePath} -show drun";
      "super + d" = "${packagePath} -show run";
      "super + q" =
        "${packagePath} -show p -modi 'p:${getExe cfg.powermenu.package}'";
    };

    programs.rofi = {
      enable = true;
      package = cfg.package;
      cycle = true;
      font = cfg.font;
      plugins = [ ] ++ optional cfg.powermenu.enable cfg.powermenu.package;
      terminal = getExe terminal;
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
