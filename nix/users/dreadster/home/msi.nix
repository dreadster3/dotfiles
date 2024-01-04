{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = {
    x11eventcallbacks = { enable = true; };
    polybar = {
      monitor = "eDP-1-1";
      networkInterface = {
        name = "wlo1";
        type = "wireless";
      };
      useBattery = true;
      useBrightness = true;
    };
    bspwm = { monitor = "eDP-1-1"; };
    fusuma = { enable = true; };
    spicetify = { enable = true; };
    xbindkeys = {
      settings = {
        "XF86AudioRaiseVolume" = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };
    };
  };
}
