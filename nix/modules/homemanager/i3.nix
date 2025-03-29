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
    services.polybar.config."bar/main".wm-restack = "i3";

    xsession.windowManager.i3 = {
      enable = true;
      package = cfg.package;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        bars = [ ];

        defaultWorkspace = "workspace 1";

        keybindings =
          let modifier = config.xsession.windowManager.i3.config.modifier;
          in mkOptionDefault {
            "${modifier}+w" = "kill";
            "${modifier}+Control+q" = "exec loginctl lock-session";

            "${modifier}+Control+Left" = "workspace next";
            "${modifier}+Control+Right" = "workspace next";

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

            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";

            "${modifier}+Shift+h" = "split h";
            "${modifier}+Shift+v" = "split v";
          };

        gaps = {
          inner = 10;
          outer = 5;
          smartGaps = true;
        };

        workspaceOutputAssign = foldlAttrs (acc: name: monitor:
          acc ++ (map (value: {
            output = name;
            workspace = toString value;
          }) monitor.workspaces)) [ ] monitors;

        startup = [
          {
            command =
              "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            notification = false;
            always = false;
          }
          {
            command = "xsetroot -cursor_name left_ptr";
            notification = false;
            always = false;
          }
        ];

      };
    };
  };
}
