{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  # inherit (config.lib.formats.rasi) mkLiteral;
  mkInline = lib.generators.mkLuaInline;
  cfg = config.modules.homemanager.rofi;
  packagePath = getExe config.programs.rofi.finalPackage;
  terminal = either cfg.terminal config.modules.homemanager.settings.terminal;
in
{
  options = {
    modules.homemanager.rofi = {
      enable = mkEnableOption "rofi";
      package = mkOption {
        type = types.package;
        default = pkgs.rofi;
        description = "Package to use for rofi";
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
      "super + q" = "${packagePath} -show p -modi 'p:${getExe cfg.powermenu.package}'";
    };

    wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + D"
          (mkInline ''hl.dsp.exec_cmd("pkill rofi || ${packagePath} -show drun")'')
        ];
      }
      {
        _args = [
          "SUPER + Space"
          (mkInline ''hl.dsp.exec_cmd("pkill rofi || ${packagePath} -show drun")'')
        ];
      }
    ];

    xsession.windowManager.i3.config.keybindings =
      let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in
      mkOptionDefault {
        "${modifier}+space" = "exec pkill rofi || ${packagePath} -show drun";
        "${modifier}+q" =
          "exec pkill rofi || ${packagePath} -show p -modi 'p:${getExe cfg.powermenu.package}'";
      };

    programs.rofi = {
      enable = true;
      inherit (cfg) package;
      cycle = true;
      plugins = optional cfg.powermenu.enable cfg.powermenu.package;
      terminal = getExe terminal;
      location = "center";
      theme = import ./theme.nix { inherit config lib; };
      extraConfig = {
        modi = "drun";
        show-icons = true;
        display-drun = " ";
        drun-display-format = "{name}";
        matching = "fuzzy";
      };
    };

    xdg.configFile."rofi/powermenu.rasi" = {
      source = ./powermenu.rasi;
    };
  };
}
