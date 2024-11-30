{ config, lib, pkgs, pkgs-unstable, ... }:
let
  primaryMonitor = "eDP-0";

  terminal = pkgs.alacritty;
in {
  imports = [ ./base/personal.nix ];

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
    settings = {
      monitors = {
        x11 = {
          eDP-0 = {
            primary = true;
            workspaces = [ 1 2 3 4 5 ];
          };
        };
        wayland = {
          eDP-1 = {
            resolution = "1920x1080";
            position = "0x0";
            zoom = "1.25";
            workspaces = [ 6 7 8 9 10 ];
          };
          DP-3 = {
            primary = true;
            resolution = "1920x1080";
            zoom = "1.25";
            position = "auto";
            workspaces = [ 1 2 3 4 5 ];
          };
          DP-4 = {
            primary = true;
            resolution = "1920x1080";
            zoom = "1.0";
            position = "auto";
            workspaces = [ 1 2 3 4 5 ];
          };
        };
      };
    };
    betterlockscreen.enable = true;
    dunst.enable = true;
    picom.enable = true;
    flameshot.enable = true;
    spicetify.enable = true;
    helix.enable = true;
    thunderbird.enable = true;
    gtk.enable = true;
    mechvibes.enable = true;
    mangohud.enable = true;
    firefox.enable = true;

    polybar.enable = true;
    rofi.enable = true;
    sxhkd.enable = true;
    bspwm = {
      enable = true;
      startupPrograms = [
        "${lib.getExe pkgs.xorg.xrandr} --output ${primaryMonitor} --primary"
        "${lib.getExe pkgs.xorg.xrandr} --output rdp0 --primary"
        "${pkgs.xbindkeys}/bin/xbindkeys"
      ];
    };
    xbindkeys = {
      enable = true;
      settings = {
        "XF86AudioRaiseVolume" = "amixer -D pipewire sset Master 5%+";
        "XF86AudioLowerVolume" = "amixer -D pipewire sset Master 5%-";
        "XF86AudioMute" = "amixer -D pipewire set Master 1+ toggle";
        "XF86AudioPlay" =
          "${lib.getExe pkgs.playerctl} --player spotify play-pause";
        "XF86AudioPrev" =
          "${lib.getExe pkgs.playerctl} --player spotify previous";
        "XF86AudioNext" = "${lib.getExe pkgs.playerctl} --player spotify next";
      };
    };

    pentest.enable = true;

    # Hyprland
    hyprland.enable = true;
    hyprpaper = {
      enable = true;
      wallpapers = { "eDP-1" = ../../../../wallpapers/shinobu.jpg; };
    };
    wlogout.enable = true;
    swaylock.enable = true;
    swayidle.enable = true;
    waybar = {
      enable = true;
      brightness.enable = true;
      battery.enable = true;
    };
  };
}
