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

            "${modifier}+1" = "workspace 1";
            "${modifier}+2" = "workspace 2";
            "${modifier}+3" = "workspace 3";
            "${modifier}+4" = "workspace 4";
            "${modifier}+5" = "workspace 5";
            "${modifier}+6" = "workspace 6";
            "${modifier}+7" = "workspace 7";
            "${modifier}+8" = "workspace 8";
            "${modifier}+9" = "workspace 9";
            "${modifier}+0" = "workspace 10";

            "${modifier}+Shift+1" = "move container to workspace 1";
            "${modifier}+Shift+2" = "move container to workspace 2";
            "${modifier}+Shift+3" = "move container to workspace 3";
            "${modifier}+Shift+4" = "move container to workspace 4";
            "${modifier}+Shift+5" = "move container to workspace 5";
            "${modifier}+Shift+6" = "move container to workspace 6";
            "${modifier}+Shift+7" = "move container to workspace 7";
            "${modifier}+Shift+8" = "move container to workspace 8";
            "${modifier}+Shift+9" = "move container to workspace 9";
            "${modifier}+Shift+0" = "move container to workspace 10";
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
            workspace = "number ${toString value}";
          }) monitor.workspaces)) [ ] monitors;

      };
    };
  };
}
