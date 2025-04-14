{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.homemanager.waybar;
  monitors = config.modules.homemanager.settings.monitors.wayland;
in {
  options = {
    modules.homemanager.waybar = {
      enable = mkEnableOption "waybar";
      package = mkOption {
        type = types.package;
        default = pkgs.waybar;
        description = "The waybar package to use.";
      };
      brightness = mkOption {
        description = "Enable brightness module";
        default = { };
        type = types.submodule {
          options = {
            enable = mkEnableOption "waybar.brightness";
            step = mkOption {
              type = types.int;
              default = 5;
            };
          };
        };
      };
      battery = mkOption {
        description = "Enable battery module";
        default = { };
        type = types.submodule {
          options = { enable = mkEnableOption "waybar.battery"; };
        };
      };
    };
  };
  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.wayland.windowManager.hyprland.enable;
      message = "waybar requires the hyprland window manager to be enabled";
    }];

    home.packages = optional cfg.brightness.enable pkgs.brightnessctl;

    nixpkgs.overlays = [
      (_: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];

    wayland.windowManager.hyprland.settings.exec-once =
      [ "${cfg.package}/bin/waybar &" ];

    programs.waybar = {
      inherit (cfg) package;

      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          modules-left =
            [ "custom/launcher" "hyprland/workspaces" "cpu" "memory" "disk" ];
          modules-center = [ "clock" ];
          modules-right = optional cfg.battery.enable "battery"
            ++ optional cfg.brightness.enable "backlight"
            ++ [ "pulseaudio" "tray" ];
          "custom/launcher" = {
            format = "";
            on-click = "pkill rofi || ${
                getExe config.programs.rofi.finalPackage
              } -show drun";
            tooltip = false;
          };
          "hyprland/workspaces" = {
            on-click = "activate";
            on-scroll-down = "hyprctl dispatch workspace r-1";
            on-scroll-up = "hyprctl dispatch workspace r+1";
            format = "{icon}";
            format-icons = {
              active = "";
              empty = "";
              default = "";
            };

            active-only = false;
            persistent-workspaces =
              mapAttrs (_: value: value.workspaces) monitors;
          };
          cpu = {
            interval = 10;
            format = " {usage}%";
            max-length = 10;
            on-click = "alacritty -e btop";
          };
          memory = {
            interval = 30;
            format = " {}%";
            max-length = 10;
            on-click = "alacritty -e btop";
          };
          disk = {
            interval = 30;
            format = "󰋊 {percentage_used}%";
            path = "/";
            on-click = "thunar";
          };
          clock = {
            format = "  {:%d/%m/%Y %H:%M}  ";
            tooltip-format = "  {:%d %B %Y %T}  ";
          };
          tray = {
            spacing = 8;
            show-passive-items = true;
          };
          pulseaudio = {
            scroll-step = 5;
            format = "{volume}% {icon}";
            format-bluetooth = "{volume}% {icon}  {format_source}";
            format-bluetooth-muted = " {icon}  {format_source}";
            format-muted = "Muted  ";
            format-icons = {
              headphone = "󰋋";
              hands-free = "󰥰";
              headset = "󰋎";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" " " ];
            };
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "pavucontrol";
            on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          };
          backlight = {
            device = "intel_backlight";
            format = "{percent}% {icon}";
            format-icons = [ "󰃞" "󰃟" "󰃠" ];
            on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set ${
                toString cfg.brightness.step
              }%+";
            on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set ${
                toString cfg.brightness.step
              }%-";
            min-length = 4;
          };
          battery = {
            states = {
              "warning" = 30;
              "critical" = 15;
            };

            format = "{capacity}% {icon}";
            format-alt = "{time} {icon}";
            format-icons = {
              default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
              charging = "󰂄";
              plugged = "󰂄";
            };
          };
        };
      };
    };
  };
}
