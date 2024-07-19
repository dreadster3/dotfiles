{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.wlogout;
in {
  options = {
    modules.homemanager.wlogout = {
      enable = mkEnableOption "wlogout";
      package = mkOption {
        type = types.package;
        default = pkgs.wlogout;
        description = "The package to use for wlogout";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.wayland.windowManager.hyprland.enable;
      message = "wlogout requires the hyprland window manager to be enabled";
    }];

    wayland.windowManager.hyprland.settings.bind =
      [ "$mainMod, Q, exec, ${cfg.package}/bin/wlogout" ];

    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          text = "Lock";
          action = "loginctl lock-session";
          keybind = "l";
        }
        {
          label = "reboot";
          text = "Reboot";
          action = "systemctl reboot";
          keybind = "r";
        }
        {
          label = "shutdown";
          text = "Shutdown";
          action = "systemctl poweroff";
          keybind = "s";
        }
        {
          label = "suspend";
          text = "Suspend";
          action = "systemctl suspend";
          keybind = "u";
        }
        {
          label = "logout";
          text = "Logout";
          action = "hyprctl dispacth exit";
          keybind = "o";
        }
      ];
      style = import ./style.nix { inherit config; };
    };

  };
}
