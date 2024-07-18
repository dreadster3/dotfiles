{ config, lib, pkgs, pkgs-unstable, ... }:
let
  primaryMonitor = "DP-0";
  secondaryMonitor = "HDMI-0";

  terminal = pkgs.alacritty;
in {
  imports = [ ./default.nix ];

  home.packages = with pkgs; [
    playerctl
    remmina

    wineWowPackages.stable
    pkgs.unstable.winetricks

    discord
    betterdiscordctl

    qalculate-gtk
    gucharmap

    postman
    dbeaver-bin

    hypnotix
  ];

  modules.homemanager = {
    betterlockscreen.enable = true;
    dunst.enable = true;
    picom.enable = true;
    aio.enable = true;
    spicetify.enable = true;
    helix.enable = true;
    thunderbird.enable = true;
    gtk.enable = true;
    mechvibes.enable = true;

    neovim.terminal = terminal;

    polybar = {
      enable = true;
      terminal = terminal;
    };
    rofi = {
      enable = true;
      terminal = terminal;
    };
    sxhkd = {
      enable = true;
      terminal = terminal;
    };
    bspwm = {
      enable = true;
      monitors = {
        "${primaryMonitor}" = [ "1" "2" "3" "4" "5" ];
        "${secondaryMonitor}" = [ "6" "7" "8" "9" "10" ];
      };
      startupPrograms = [
        "MONITOR='${primaryMonitor}' ${pkgs.polybar}/bin/polybar main"
        "MONITOR='${secondaryMonitor}' ${pkgs.polybar}/bin/polybar secondary"
        "${
          lib.getExe pkgs.xorg.xrandr
        } --output ${primaryMonitor} --primary --output ${secondaryMonitor} --left-of ${primaryMonitor} --rotate left"
        "${lib.getExe pkgs.xorg.xrandr} --output rdp0 --primary"
        "${pkgs.xbindkeys}/bin/xbindkeys"
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

    pentest.enable = true;

    # Hyprland
    hyprland = {
      enable = true;
      terminal = terminal;
    };
    hyprpaper = {
      enable = true;
      wallpapers = {
        "DP-1" = ../../../../wallpapers/shinobu.jpg;
        "HDMI-A-1" = ../../../../wallpapers/anime_vertical.png;
      };
    };
    wlogout.enable = true;
    swaylock.enable = true;
    swayidle.enable = true;
    wofi.enable = true;
    waybar.enable = true;
  };
}
