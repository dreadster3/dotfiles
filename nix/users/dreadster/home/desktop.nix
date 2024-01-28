{ config, lib, pkgs, ... }:
let
  primaryMonitor = "DP-0";
  secondaryMonitor = "HDMI-0";
in {
  imports = [ ./default.nix ];

  home.packages = with pkgs; [ playerctl ];

  modules = {
    aio = { enable = true; };
    waybar = { enable = true; };
    wofi = { enable = true; };
    hyprland = { enable = true; };
    gtk = {
      enable = true;
      cursor = { enable = true; };
    };
    # guake = { enable = true; };
    dunst = { enable = true; };
    polybar = {
      enable = true;
      terminal = pkgs.wezterm;
      secondMonitor = secondaryMonitor;
      useTray = true;
    };
    rofi = { enable = true; };
    sxhkd = {
      enable = true;
      terminal = pkgs.wezterm;
    };
    bspwm = {
      enable = true;
      startupPrograms = [
        "xrandr --output ${primaryMonitor} --primary --output ${secondaryMonitor} --left-of ${primaryMonitor} --rotate left"
        "xbindkeys"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];
    };
    picom = { enable = true; };
    spicetify = { enable = true; };
    xbindkeys = {
      enable = true;
      settings = {
        "XF86AudioRaiseVolume" = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioPlay" =
          "${lib.getExe pkgs.playerctl} --player spotify play-pause";
        "XF86AudioPrev" =
          "${lib.getExe pkgs.playerctl} --player spotify previous";
        "XF86AudioNext" = "${lib.getExe pkgs.playerctl} --player spotify next";
      };
    };
    betterlockscreen = { enable = true; };
  };
}
