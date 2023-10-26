{ config, lib, pkgs, username, ... }:
with lib;
let cfg = config.modules.polybar;
in {
  options = {
    modules.polybar = {
      enable = mkEnableOption "polybar";
      monitor = mkOption {
        type = types.str;
        default = "eDP-1";
        description = "The monitor to display the bar on";
      };
      terminal = mkOption {
        type = types.package;
        default = pkgs.kitty;
        description = "The terminal to use";
      };
      extraConfig = mkOption {
        type = types.str;
        default = "";
        description = "Extra config to append to the polybar config";
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rofi-power-menu ];
    services = {
      polybar = {
        enable = true;
        package = pkgs.polybar.override {
          alsaSupport = true;
          pulseSupport = true;
        };
        script = "	MONITOR=\"${cfg.monitor}\"\n\n	polybar main &\n";
        extraConfig = cfg.extraConfig;
        config = {
          "bar/main" = {
            monitor = "\${env:MONITOR:}";

            # Size
            width = "99%";
            height = "36";

            # Position
            bottom = false;
            fixed-center = true;
            offset-x = "10";
            offset-y = "2%";

            # Appearance
            background = "\${colorscheme.background}";
            foreground = "\${colorscheme.foreground}";
            radius = 10;
            border-size = 0;

            # Fonts
            font-0 = "Fira Code Nerd Font:pixelsize=12;3";
            font-1 = "Iosevka Nerd Font:pixelsize=14;4";

            # Modules
            # modules-left = "launcher workspaces ranger github reddit firefox azure monitor";
            modules-left = "launcher workspaces firefox";
            modules-center = "date";
            # modules-right = "alsa network cpu filesystem memory sysmenu";
            modules-right = "alsa";

            # Window Manager
            wm-restack = "bspwm";
          };
          "module/alsa" = {
            type = "internal/alsa";
            master-soundcard = "default";
            speaker-soundcard = "default";
            headphone-soundcard = "default";
            master-mixer = "Master";
            interval = 5;

            # Volume Label Format
            format-volume = "<ramp-volume> <label-volume>";
            format-volume-background = "\${colorscheme.base}";
            format-volume-foreground = "\${colorscheme.sapphire}";
            format-volume-padding = 2;
            # Mute Volume Label Format
            format-muted = "<label-muted>";
            format-muted-prefix = "󰝟";
            format-muted-background = "\${colorscheme.surface0}";
            format-muted-foreground = "\${colorscheme.blue}";
            format-muted-padding = 2;

            # Volume Label
            label-volume = "%percentage%%";

            # Mute Volume Label
            label-muted = "Muted";

            # Ramp Volume Icons
            ramp-volume-0 = "󰕿";
            ramp-volume-1 = "󰖀";
            ramp-volume-2 = "󰕾";
            ramp-headphones-0 = "";

            # Click Events
            click-right = "pavucontrol &";
          };
          "module/date" = {
            type = "internal/date";
            interval = "1.0";
            # Alt = When pressed
            date = " %d %b";
            date-alt = " %a, %d %b %Y";
            time = " %H:%M";
            time-alt = " %H:%M:%S";

            # Label Format
            format = "<label>";
            format-background = "\${colorscheme.base}";
            format-foreground = "\${colorscheme.text}";
            format-padding = "2";

            # Label
            label = "%date% %time%";
          };

          "module/workspaces" = {
            type = "internal/xworkspaces";
            pin-workspaces = true;
            enable-click = true;
            enable-scroll = true;

            # Label Format
            format = "<label-state>";
            format-padding = "1";
            format-background = "\${colorscheme.base}";
            format-foreground = "\${colorscheme.teal}";

            # Label
            label-monitor = "%name%";
            label-active = "";
            label-active-padding = 1;
            label-occupied = "";
            label-occupied-padding = 1;
            label-urgent = "";
            label-urgent-padding = 1;
            label-empty = "";
            label-empty-padding = 1;
          };

          "module/launcher" = {
            type = "custom/text";
            content = "";
            content-background = "\${colorscheme.base}";
            content-foreground = "\${colorscheme.green}";
            content-padding = 2;
            click-left = "${lib.getExe pkgs.rofi} -show drun";
          };

          "module/links" = {
            type = "custom/text";
            content-foreground = "\${colorscheme.subtext0}";
            content-padding = 2;
          };

          "module/firefox" = {
            "inherit" = "module/links";
            content = "";
            click-left = "${lib.getExe pkgs.firefox} &";
            click-right = "${lib.getExe pkgs.firefox} --private-window &";
          };

          "colorscheme" = {
            # Base Colors
            background = "#222436";
            foreground = "#c8d3f5";
            foreground-alt = "#8f8f8f";
            base = "#CD1e1e2e";
            mantle = "#181825";
            crust = "#11111b";
            text = "#cdd6f4";
            subtext0 = "#a6adc8";
            subtext1 = "#bac2de";
            surface0 = "#313244";
            surface1 = "#45475a";
            surface2 = "#585b70";
            overlay0 = "#6c7086";
            overlay1 = "#7f849c";
            overlay2 = "#9399b2";

            # Accent Colors
            blue = "#89b4fa";
            lavender = "#b4befe";
            sapphire = "#74c7ec";
            sky = "#89dceb";
            teal = "#94e2d5";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            peach = "#fab387";
            maroon = "#eba0ac";
            red = "#f38ba8";
            mauve = "#cba6f7";
            pink = "#f5c2e7";
            flamingo = "#f2cdcd";
            rosewater = "#f5e0dc";
            transparent = "#FF00000";
          };
        };
      };
    };

    systemd.user.services.polybar = {
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
