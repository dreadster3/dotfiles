{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.waybar;
in {
  options = {
    modules.homemanager.waybar = { enable = mkEnableOption "waybar"; };
  };
  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];

    programs.waybar = {
      enable = true;
      # systemd.enable = true;
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
            persistent-workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
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
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pavucontrol";
            on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
            on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
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
