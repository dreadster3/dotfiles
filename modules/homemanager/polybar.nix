{ config, lib, pkgs, username, ... }:
with lib;
let
  cfg = config.modules.polybar;

  battery_module = if cfg.useBattery then [ "battery" ] else [ ];
  brightness_module = if cfg.useBrightness then [ "backlight" ] else [ ];

  modules_left = [
    "launcher"
    "workspaces"
    "ranger"
    "github"
    "reddit"
    "firefox"
    "azure"
    "monitor"
  ];

  modules_center = [ "date" ];

  modules_right = [ "alsa" "network" "cpu" "filesystem" "memory" ]
    ++ battery_module ++ brightness_module ++ [ "sysmenu" ];

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
      filemanager = mkOption {
        type = types.package;
        default = pkgs.xfce.thunar;
        description = "The filemanager to use";
      };
      networkInterface = mkOption {
        default = { };
        description = "The network interface to use";
        type = types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              default = "ens33";
              description = "The network interface to use";
            };
            type = mkOption {
              type = types.str;
              default = "wired";
              description = "The type of the module";
            };
          };
        };
      };
      useBattery = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to include battery in polybar";
      };
      useBrightness = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to include brightness in polybar";
      };
      extraConfig = mkOption {
        type = types.str;
        default = "";
        description = "Extra config to append to the polybar config";
      };
    };
  };
  config = mkIf cfg.enable {
    services = {
      polybar = {
        enable = true;
        package = pkgs.polybar.override {
          alsaSupport = true;
          pulseSupport = true;
        };
        script = ''
          polybar main &
        '';
        extraConfig = cfg.extraConfig;
        config = {
          "bar/main" = {
            monitor = "${cfg.monitor}";

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
            modules-left = modules_left;
            modules-center = modules_center;
            modules-right = modules_right;

            # Window Manager
            wm-restack = "bspwm";
          };
          "module/cpu" = {
            type = "internal/cpu";
            interval = 1;
            warn-percentage = 90;

            # Label Format
            format = "<label>";
            format-prefix = ''"  "'';
            format-background = "\${colorscheme.base}";
            format-foreground = "\${colorscheme.yellow}";
            format-padding = 2;
            label = "%percentage%%";

            # Warn Label Format
            format-warn = "<label-warn>";
            format-warn-prefix = ''"  "'';
            format-warn-background = "\${colorscheme.base}";
            format-warn-foreground = "\${colorscheme.red}";
            format-warn-padding = 2;
            label-warn = "%percentage%%";
          };

          "module/backlight" = {
            type = "internal/backlight";
            card = "intel_backlight";
            enable-scroll = true;

            # Label
            format = "<ramp> <label>";
            format-background = "\${colorscheme.base}";
            format-foreground = "\${colorscheme.yellow}";
            format-padding = 2;
            label = "%percentage%%";

            # Ramp
            ramp-0 = "󰃜";
            ramp-1 = "󰃝";
            ramp-2 = "󰃞";
            ramp-3 = "󰃟";
            ramp-4 = "󰃠";
          };

          "module/battery" = {
            type = "internal/battery";
            full-at = 99;
            low-at = 20;
            battery = "BAT1";
            adapter = "ADP1";
            poll-interval = 5;
            time-format = "%H:%M";

            format-charging = "<animation-charging> <label-charging>";
            format-charging-foreground = "\${colorscheme.green}";
            format-charging-background = "\${colorscheme.base}";
            format-charging-padding = 2;
            label-charging = "%percentage%%";

            format-discharging = "<ramp-capacity> <label-discharging>";
            format-discharging-foreground = "\${colorscheme.yellow}";
            format-discharging-background = "\${colorscheme.base}";
            format-discharging-padding = 2;
            label-discharging = "%percentage%%";

            format-full = "<label-full>";
            format-full-prefix = ''"󰂅 "'';
            format-full-foreground = "\${colorscheme.green}";
            format-full-background = "\${colorscheme.base}";
            format-full-padding = 2;
            label-full = "Full";

            ramp-capacity-0 = "󰂎";
            ramp-capacity-1 = "󰁺";
            ramp-capacity-2 = "󰁻";
            ramp-capacity-3 = "󰁼";
            ramp-capacity-4 = "󰁽";
            ramp-capacity-5 = "󰁾";
            ramp-capacity-6 = "󰁿";
            ramp-capacity-7 = "󰂀";
            ramp-capacity-8 = "󰂁";
            ramp-capacity-9 = "󰂂";
            ramp-capacity-10 = "󰁹";

            animation-charging-0 = "󰢟";
            animation-charging-1 = "󰢜";
            animation-charging-2 = "󰂆";
            animation-charging-3 = "󰂇";
            animation-charging-4 = "󰂈";
            animation-charging-5 = "󰢝";
            animation-charging-6 = "󰂉";
            animation-charging-7 = "󰢞";
            animation-charging-8 = "󰂊";
            animation-charging-9 = "󰂋";
            animation-charging-10 = "󰂅";
            animation-charging-framerate = 750;
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
            label-volume = "%percentage%%";

            # Mute Volume Label Format
            format-muted = "<label-muted>";
            format-muted-prefix = ''"󰝟 "'';
            format-muted-background = "\${colorscheme.surface0}";
            format-muted-foreground = "\${colorscheme.blue}";
            format-muted-padding = 2;
            label-muted = "Muted";

            # Ramp Volume Icons
            ramp-volume-0 = "󰕿";
            ramp-volume-1 = "󰖀";
            ramp-volume-2 = "󰕾";
            ramp-headphones-0 = "";

            # Click Events
            click-right = "pavucontrol &";
          };
          "module/network" = {
            type = "internal/network";
            interface = "${cfg.networkInterface.name}";
            interface-type = "${cfg.networkInterface.type}";
            interval = 1;
            accumulate-stats = true;
            unknown-as-up = true;

            # Format Connected Label
            format-connected = "<label-connected>";
            format-connected-background = "\${colorscheme.base}";
            format-connected-padding = "2";

            # Format Disconnected Label
            format-disconnected = "<label-disconnected>";
            format-disconnected-prefix = "󰈂";
            format-disconnected-background = "\${colorscheme.base}";
            format-disconnected-padding = "2";

            # Label Connected
            label-connected =
              "%{A1:networkmanager_dmenu &:} %upspeed%  %downspeed% %{A}";
            label-connected-foreground = "\${colorscheme.lavender}";

            # Label Disconnected
            label-disconnected = "%{A1:networkmanager_dmenu &:} Offline%{A}";
            label-disconnected-foreground = "\${colorscheme.lavender}";
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

          "module/filesystem" = {
            type = "internal/fs";

            mount-0 = "/";
            interval = 60;
            fixed-values = true;

            # Format Mounted Label
            format-mounted = "<label-mounted>";
            format-mounted-prefix = ''"󰋊 "'';
            format-mounted-background = "\${colorscheme.base}";
            format-mounted-foreground = "\${colorscheme.peach}";
            format-mounted-padding = "2";
            label-mounted = "%percentage_used%%";

            # Format Unmounted Label
            format-unmounted = "<label-unmounted>";
            format-unmounted-prefix = ''"󰋊 "'';
            format-unmounted-background = "\${colorscheme.shade4}";
            format-unmounted-padding = "2";
            label-unmounted = "%mountpoint%: not mounted";

          };

          "module/memory" = {
            type = "internal/memory";
            interval = 1;

            warn-percentage = 90;

            # Format Label
            format = "<label>";
            format-prefix = ''"  "'';
            format-background = "\${colorscheme.base}";
            format-foreground = "\${colorscheme.maroon}";
            format-padding = 2;
            label = "%percentage_used%%";

            # Format Warn Label
            format-warn = "<label-warn>";
            format-warn-prefix = ''"  "'';
            format-warn-background = "\${colorscheme.base}";
            format-warn-foreground = "\${colorscheme.red}";
            format-warn-padding = 2;
            label-warn = "%percentage_used%%";
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

          "module/ranger" = {
            "inherit" = "module/links";
            content = "";
            click-left =
              "${lib.getExe cfg.terminal} -e ${lib.getExe pkgs.ranger} ~ &";
            click-right = "${lib.getExe cfg.filemanager} &";
          };

          "module/monitor" = {
            "inherit" = "module/links";
            content = "";
            click-left =
              "${lib.getExe cfg.terminal} -e ${lib.getExe pkgs.btop} &";
          };

          "module/github" = {
            "inherit" = "module/links";
            content = "";
            click-left =
              "${lib.getExe pkgs.firefox} https://github.com/dreadster3 &";
          };

          "module/reddit" = {
            "inherit" = "module/links";
            content = "";
            click-left = "${lib.getExe pkgs.firefox} https://reddit.com &";
          };

          "module/azure" = {
            "inherit" = "module/links";
            content = "󰠅";
            click-left =
              "${lib.getExe pkgs.firefox} https://portal.azure.com &";
          };

          "module/sysmenu" = {
            type = "custom/text";
            content = "⏻";
            content-foreground = "\${colorscheme.base}";
            content-background = "\${colorscheme.red}";
            content-padding = 2;

            click-left = toString (pkgs.writers.writeBash "launch_powermenu" ''
              			  PATH=/run/current-system/sw/bin:$PATH

                            ${lib.getExe pkgs.rofi} -show p -modi "p:${
                              lib.getExe pkgs.rofi-power-menu
                            }"
              			'');
          };

          "colorscheme" = {
            # Base Colors
            background = "#222436";
            foreground = "#c8d3f5";
            foreground-alt = "#8f8f8f";
            base = "#cd1e1e2e";
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
