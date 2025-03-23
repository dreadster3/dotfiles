{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.homemanager.i3;
  monitors = config.modules.homemanager.settings.monitors.x11;
in {
  options = {
    modules.homemanager.i3 = {
      enable = mkEnableOption "i3";
      package = mkOption {
        type = types.package;
        default = pkgs.i3;
      };
    };
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = cfg.package;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        bars = [ ];

        defaultWorkspace = "workspace number 1";

        keybindings =
          let modifier = config.xsession.windowManager.i3.config.modifier;
          in mkOptionDefault {
            "${modifier}+w" = "kill";
            "${modifier}+l" = "exec loginctl lock-session";
            "${modifier}+Control+q" = "exec loginctl lock-session";
          };

        gaps = {
          inner = 10;
          outer = 5;
          smartGaps = true;
        };

        # workspaceOutputAssign = mapAttrsToList (name: monitor:
        #   (map (value: {
        #     output = name;
        #     workspace = value;
        #   }) monitor.workspaces)) monitors;

        workspaceOutputAssign = foldlAttrs (acc: name: monitor:
          acc ++ (map (value: {
            output = name;
            workspace = toString value;
          }) monitor.workspaces)) [ ] monitors;

      };
    };
  };
}
