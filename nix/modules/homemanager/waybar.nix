{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.homemanager.waybar;
  monitor1 = "DP-1";
  monitor2 = "HDMI-A-1";
in {
  options = {
    modules.homemanager.waybar = {
      enable = mkEnableOption "waybar";
      package = mkOption {
        type = types.package;
        default = pkgs.waybar;
        description = "The waybar package to use.";
      };
    };
  };
  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.wayland.windowManager.hyprland.enable;
      message = "waybar requires the hyprland window manager to be enabled";
    }];

    nixpkgs.overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];

    wayland.windowManager.hyprland.settings.exec-once =
      [ "${cfg.package}/bin/waybar &" ];

    programs.waybar = {
      enable = true;
      package = cfg.package;
      settings = {
        mainBar = {
          layer = "top";
          modules-left =
            [ "custom/wofi" "hyprland/workspaces" "cpu" "memory" "disk" ];
          modules-center = [ "clock" ];
          modules-right = [ "pulseaudio" "tray" ];
          # output = [ "DP-1" "HDMI-A-1" ];
          "custom/wofi" = {
            format = "";
            on-click = "pkill wofi || wofi";
            tooltip = false;
          };
          "hyprland/workspaces" = {
            on-click = "activate";
            on-scroll-down = "hyprctl dispatch workspace r-1";
            on-scroll-up = "hyprctl dispatch workspace r+1";
            format = "{icon}";
            active-only = true;
            persistent-workspaces = {
              "${monitor1}" = [ 1 2 3 4 5 ];
              "${monitor2}" = [ 6 7 8 9 10 ];
            };
          };
          "cpu" = {
            interval = 10;
            format = "   {usage}%";
            max-length = 10;
          };
          "memory" = {
            interval = 30;
            format = "   {}%";
            max-length = 10;
          };
          "disk" = {
            interval = 30;
            format = "󰋊  {percentage_used}%";
            path = "/";
          };
          "clock" = { format = "  {:%e %b %Y %H:%M}  "; };
          "tray" = { spacing = 8; };
          "pulseaudio" = {
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
              default = [ "" ];
            };
            on-click = "amixer -D pipewire set Master 1+ toggle";
            on-click-right = "pavucontrol";
            on-scroll-up = "amixer -D pipewire sset Master 1%+";
            on-scroll-down = "amixer -D pipewire sset Master 1%-";
          };
        };
      };
      style = ../../../configurations/waybar/style.css;
    };

    xdg.configFile."waybar/mocha.css" = {
      source = ../../../configurations/waybar/mocha.css;
      onChange = ''
        ${pkgs.procps}/bin/pkill -u $USER -USR2 waybar || true
      '';
    };
  };
}
