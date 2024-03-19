{ config, lib, pkgs, ... }:
let
  primaryMonitor = "DP-0";
  secondaryMonitor = "HDMI-0";
in {
  imports = [ ./default.nix ];

  home.packages = with pkgs; [ playerctl ];

  modules.homemanager = {
    betterlockscreen.enable = true;
    dunst.enable = true;
    picom.enable = true;
    aio.enable = true;
    spicetify.enable = true;
    helix.enable = true;
    tint2.enable = true;
    rofi.enable = true;
    sxhkd.enable = true;

    gtk = {
      enable = true;
      cursor.enable = true;
    };
    bspwm = {
      enable = true;
      monitors = {
        "${primaryMonitor}" = [ "1" "2" "3" "4" "5" ];
        "${secondaryMonitor}" = [ "6" "7" "8" "9" "10" ];
      };
      startupPrograms = [
        "${pkgs.picom}/bin/picom"
        "${pkgs.tint2}/bin/tint2"
        "${
          lib.getExe pkgs.xorg.xrandr
        } --output ${primaryMonitor} --primary --output ${secondaryMonitor} --left-of ${primaryMonitor} --rotate left"
        "${lib.getExe pkgs.xorg.xrandr} --output rdp0 --primary"
        "${pkgs.xbindkeys}/bin/xbindkeys"
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
