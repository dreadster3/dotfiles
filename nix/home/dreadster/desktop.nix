{ config, lib, pkgs, pkgs-unstable, ... }:
let
  primaryMonitor = "DP-0";
  secondaryMonitor = "HDMI-0";
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
    settings = {
      monitors = {
        x11 = {
          DP-0 = {
            primary = true;
            workspaces = [ 1 2 3 4 5 ];
          };
          HDMI-A-0 = { workspaces = [ 6 7 8 9 10 ]; };
        };

        wayland = {
          DP-1 = {
            primary = true;
            resolution = "preferred";
            position = "1080x0";
            transform = null;
            workspaces = [ 1 2 3 4 5 ];
            zoom = "auto";
          };
          HDMI-A-1 = {
            resolution = "preferred";
            position = "0x0";
            transform = 1;
            workspaces = [ 6 7 8 9 10 ];
            zoom = "auto";
          };
        };
      };
    };

    betterlockscreen.enable = true;
    dunst.enable = true;
    picom.enable = true;
    aio.enable = true;
    spicetify.enable = true;
    helix.enable = true;
    thunderbird.enable = true;
    gtk.enable = true;
    mechvibes.enable = true;

    polybar.enable = true;
    rofi.enable = true;
    sxhkd.enable = true;
    bspwm = {
      enable = true;
      startupPrograms = [
        "${
          lib.getExe pkgs.xorg.xrandr
        } --output ${primaryMonitor} --primary --output ${secondaryMonitor} --left-of ${primaryMonitor} --rotate left"
        "${lib.getExe pkgs.xorg.xrandr} --output rdp0 --primary"
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
