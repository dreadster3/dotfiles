{ config, lib, pkgs, ... }:
let
  primaryMonitor = "DP-0";
  secondaryMonitor = "HDMI-0";

  polybar_start = pkgs.writers.writeBash "polybar_multi_monitor" ''
    MONITOR=${primaryMonitor} polybar main &
    if type "xrandr"; then
    	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    		if [ $m = "${primaryMonitor}" ]; then
    			continue
    		fi
    		MONITOR=$m polybar --reload secondary &
    	done
    fi'';
in {
  imports = [ ./default.nix ];

  home.packages = with pkgs; [ playerctl ];

  home.sessionVariables = {
    XDG_CACHE_DIR = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_DESKTOP_DIR = "$HOME/Desktop";
    XDG_DOCUMENTS_DIR = "$HOME/Documents";
    XDG_DOWNLOAD_DIR = "$HOME/Downloads";
    XDG_VIDEOS_DIR = "$HOME/Videos";
  };

  modules = {
    hyprland.enable = true;
    waybar.enable = true;
    wofi.enable = true;
    betterlockscreen.enable = true;
    dunst.enable = true;
    picom.enable = true;
    aio.enable = true;
    spicetify.enable = true;
    helix.enable = true;

    gtk = {
      enable = true;
      cursor.enable = true;
    };
    polybar = {
      enable = true;
      useTray = true;
    };
    rofi.enable = true;
    sxhkd.enable = true;
    bspwm = {
      enable = true;
      startupPrograms = [
        "${pkgs.picom}/bin/picom"
        "${polybar_start}"
        "${
          lib.getExe pkgs.xorg.xrandr
        } --output ${primaryMonitor} --primary --output ${secondaryMonitor} --left-of ${primaryMonitor} --rotate left"
        "${lib.getExe pkgs.xorg.xrandr} --output rdp0 --primary"
        "${pkgs.xbindkeys}/bin/xbindkeys"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${lib.getExe pkgs.flameshot}"
      ];
    };
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
  };
}
