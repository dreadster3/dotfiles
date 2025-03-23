{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.polybar;
  firefox = config.modules.homemanager.firefox.package;
  monitors = config.modules.homemanager.settings.monitors.x11 // cfg.monitors;
  terminal = either cfg.terminal config.modules.homemanager.settings.terminal;

  workspaces_module =
    if config.xsession.windowManager.i3.enable then "i3" else "workspaces";

  modules_left = [
    "launcher"
    workspaces_module
    "explorer"
    "github"
    "reddit"
    "firefox"
    "azure"
    "monitor"
  ];

  modules_center = [ "date" ];

  modules_right = optional cfg.tray.enable "tray"
    ++ [ "alsa" "network" "cpu" "filesystem" "memory" ]
    ++ optional cfg.battery.enable "battery"
    ++ optional cfg.brightness.enable "backlight" ++ [ "sysmenu" ];

in {
  options = {
    modules.homemanager.polybar = {
      enable = mkEnableOption "polybar";
      package = mkOption {
        type = types.package;
        default = pkgs.polybar;
        description = "The polybar package to use";
      };
      script = mkOption {
        type = types.str;
        readOnly = true;
        description = "The script to run polybar";
      };
      monitors = mkOption {
        type = types.monitorMap;
        default = { };
        description = "The monitors to use";
      };
      terminal = mkOption {
        type = types.nullOr types.package;
        default = null;
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
              default = "eno1";
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
      battery = mkOption {
        type = types.submodule {
          options = { enable = mkEnableOption "polybar.battery"; };
        };
        default = { };
        description = "Battery module configuration";
      };
      brightness = mkOption {
        type = types.submodule {
          options = { enable = mkEnableOption "polybar.brightness"; };
        };
        default = { };
        description = "Brightness module configuration";
      };
      tray = mkOption {
        type = types.submodule {
          options = { enable = mkEnableOption "polybar.tray"; };
        };
        default = { };
        description = "Tray module configuration";
      };
      extraConfig = mkOption {
        type = types.str;
        default = "";
        description = "Extra config to append to the polybar config";
      };
    };
  };
  config = mkIf cfg.enable {

    modules.homemanager.polybar.script = let
      path_add = "";
      monitors_reload = concatStringsSep "\n" (mapAttrsToList (name: monitor:
        "MONITOR=${name} ${getExe cfg.package} --reload ${
          if monitor.primary then "main" else "secondary"
        } &") monitors);
    in ''
      export PATH=$PATH:/run/current-system/sw/bin

      ${monitors_reload}
    '';

    programs.zsh.shellAliases = {
      polybar_all = "(pkill polybar || true) && ${
          pkgs.writers.writeBash "polybar_all" cfg.script
        }";
    };

    xsession.windowManager.i3.config.startup = [{
      command = "systemctl --user restart polybar";
      always = true;
      notification = false;
    }];

    services = {
      polybar = {
        enable = true;
        package = cfg.package.override {
          i3Support = config.xsession.windowManager.i3.enable;
        };
        script = cfg.script;
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
            offset-y = "1%";

            # Appearance
            background = "\${colors.base}";
            foreground = "\${colors.text}";
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
          };
          "bar/secondary" = {
            monitor = "\${env:MONITOR:}";

            # Size
            width = "98%";
            height = "36";

            # Position
            bottom = false;
            fixed-center = true;
            offset-x = "10";
            offset-y = "1%";

            # Appearance
            background = "\${colors.base}";
            foreground = "\${colors.text}";
            radius = 10;
            border-size = 0;

            # Fonts
            font-0 = "Fira Code Nerd Font:pixelsize=12;3";
            font-1 = "Iosevka Nerd Font:pixelsize=14;4";

            # Modules
            # modules-left = "launcher workspaces ranger github reddit firefox azure monitor";
            modules-left = modules_left;
            modules-center = modules_center;
            modules-right = [ "alsa" "cpu" "memory" "sysmenu" ];
          };
          "module/cpu" = {
            type = "internal/cpu";
            interval = 1;
            warn-percentage = 90;

            # Label Format
            format = "<label>";
            format-prefix = ''"  "'';
            format-background = "\${colors.mantle}";
            format-foreground = "\${colors.yellow}";
            format-padding = 2;
            label = "%percentage%%";

            # Warn Label Format
            format-warn = "<label-warn>";
            format-warn-prefix = ''"  "'';
            format-warn-background = "\${colors.mantle}";
            format-warn-foreground = "\${colors.red}";
            format-warn-padding = 2;
            label-warn = "%percentage%%";
          };

          "module/backlight" = {
            type = "internal/backlight";
            card = "acpi_video0";
            enable-scroll = true;

            # Label
            format = "<ramp> <label>";
            format-background = "\${colors.mantle}";
            format-foreground = "\${colors.yellow}";
            format-padding = 2;
            label = "%percentage%%";

            # Ramp
            ramp-0 = "󰃜";
            ramp-1 = "󰃝";
            ramp-2 = "󰃞";
            ramp-3 = "󰃟";
            ramp-4 = "󰃠";
          };

          "module/tray" = {
            type = "internal/tray";
            tray-padding = 7;
            tray-size = "50%";
            tray-background = "\${colors.mantle}";
            format-background = "\${colors.mantle}";
            format-padding = 1;
          };

          "module/battery" = {
            type = "internal/battery";
            full-at = 99;
            low-at = 25;
            battery = "BAT1";
            adapter = "ADP1";
            poll-interval = 5;
            time-format = "%H:%M";

            format-charging = "<animation-charging> <label-charging>";
            format-charging-foreground = "\${colors.green}";
            format-charging-background = "\${colors.mantle}";
            format-charging-padding = 2;
            label-charging = "%percentage%%";

            format-discharging = "<ramp-capacity> <label-discharging>";
            format-discharging-foreground = "\${colors.yellow}";
            format-discharging-background = "\${colors.mantle}";
            format-discharging-padding = 2;
            label-discharging = "%percentage%% (%time%)";

            format-low = "<animation-low> <label-low>";
            format-low-foreground = "\${colors.mantle}";
            format-low-background = "\${colors.red}";
            format-low-padding = 2;
            label-low = "%percentage%% (%time%)";

            format-full = "<label-full>";
            format-full-prefix = ''"󰂅 "'';
            format-full-foreground = "\${colors.green}";
            format-full-background = "\${colors.mantle}";
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

            animation-low-0 = "";
            animation-low-1 = "󰁺";
            animation-low-2 = "󰁺";
            animation-low-3 = "󰁺";
            animation-low-framerate = 1000;
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
            format-volume-background = "\${colors.mantle}";
            format-volume-foreground = "\${colors.teal}";
            format-volume-padding = 2;
            label-volume = "%percentage%%";

            # Mute Volume Label Format
            format-muted = "<label-muted>";
            format-muted-prefix = ''"󰝟 "'';
            format-muted-background = "\${colors.surface0}";
            format-muted-foreground = "\${colors.blue}";
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
            format-connected-background = "\${colors.mantle}";
            format-connected-padding = "2";

            # Format Disconnected Label
            format-disconnected = "<label-disconnected>";
            format-disconnected-prefix = "󰈂";
            format-disconnected-background = "\${colors.mantle}";
            format-disconnected-padding = "2";

            # Label Connected
            label-connected =
              "%{A1:networkmanager_dmenu &:} %upspeed%  %downspeed% %{A}";
            label-connected-foreground = "\${colors.lavender}";

            # Label Disconnected
            label-disconnected = "%{A1:networkmanager_dmenu &:} Offline%{A}";
            label-disconnected-foreground = "\${colors.lavender}";
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
            format-background = "\${colors.mantle}";
            format-foreground = "\${colors.text}";
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
            format-background = "\${colors.mantle}";
            format-foreground = "\${colors.${config.catppuccin.accent}}";

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

          "module/i3" = { type = "internal/i3"; };

          "module/filesystem" = {
            type = "internal/fs";

            mount-0 = "/";
            interval = 60;
            fixed-values = true;

            # Format Mounted Label
            format-mounted = "<label-mounted>";
            format-mounted-prefix = ''"󰋊 "'';
            format-mounted-background = "\${colors.mantle}";
            format-mounted-foreground = "\${colors.flamingo}";
            format-mounted-padding = "2";
            label-mounted = "%percentage_used%%";

            # Format Unmounted Label
            format-unmounted = "<label-unmounted>";
            format-unmounted-prefix = ''"󰋊 "'';
            format-unmounted-background = "\${colors.blue}";
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
            format-background = "\${colors.mantle}";
            format-foreground = "\${colors.peach}";
            format-padding = 2;
            label = "%percentage_used%%";

            # Format Warn Label
            format-warn = "<label-warn>";
            format-warn-prefix = ''"  "'';
            format-warn-background = "\${colors.mantle}";
            format-warn-foreground = "\${colors.red}";
            format-warn-padding = 2;
            label-warn = "%percentage_used%%";
          };

          "module/launcher" = {
            type = "custom/text";
            content = "";
            content-background = "\${colors.mantle}";
            content-foreground = "\${colors.${config.catppuccin.accent}}";
            content-padding = 2;
            click-left =
              "${getExe config.programs.rofi.finalPackage} -show drun";
          };

          "module/links" = {
            type = "custom/text";
            content-foreground = "\${colors.text}";
            content-padding = 2;
          };

          "module/firefox" = {
            "inherit" = "module/links";
            content = "";
            click-left = "${getExe firefox} &";
            click-right = "${getExe firefox} --private-window &";
          };

          "module/explorer" = {
            "inherit" = "module/links";
            content = "";
            click-left = "${getExe cfg.filemanager} &";
            click-right = "${getExe terminal} -e ${getExe pkgs.ranger} ~ &";
          };

          "module/monitor" = {
            "inherit" = "module/links";
            content = "";
            click-left =
              "${getExe terminal} -e ${getExe config.programs.btop.package} &";
          };

          "module/github" = {
            "inherit" = "module/links";
            content = "";
            click-left = "${getExe firefox} https://github.com/dreadster3 &";
          };

          "module/reddit" = {
            "inherit" = "module/links";
            content = "";
            click-left = "${getExe firefox} https://reddit.com &";
          };

          "module/azure" = {
            "inherit" = "module/links";
            content = "󰠅";
            click-left = "${getExe firefox} https://portal.azure.com &";
          };

          "module/sysmenu" = {
            type = "custom/text";
            content = "⏻";
            content-foreground = "\${colors.red}";
            content-background = "\${colors.mantle}";
            content-padding = 2;

            click-left = ''
              ${getExe config.programs.rofi.finalPackage} -show p -modi "p:${
                getExe config.modules.homemanager.rofi.powermenu.package
              }"
            '';
          };
        };
      };
    };
  };
}
