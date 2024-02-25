{ config, lib, pkgs, ... }:
let
  primaryMonitor = "Virtual1";
  secondaryMonitor = "Virtual2";
in {
  imports = [ ./default.nix ];

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
    gtk = {
      enable = true;
      cursor = { enable = true; };
    };
    dunst.enable = true;

    # X11
    polybar = {
      enable = true;
      useTray = true;
    };
    bspwm = {
      enable = true;
      monitors = {
        "${primaryMonitor}" = [ "1" "2" "3" "4" "5" ];
        "${secondaryMonitor}" = [ "6" "7" "8" "9" "10" ];
      };
      startupPrograms = [
        "${pkgs.open-vm-tools}/bin/vmware-user-suid-wrapper"
        "${lib.getExe pkgs.picom}"
        "${lib.getExe pkgs.flameshot}"
        "MONITOR='${primaryMonitor}' ${pkgs.polybar}/bin/polybar main"
      ];
    };
    sxhkd.enable = true;
    x11eventcallbacks.enable = true;
    rofi.enable = true;
    picom.enable = true;
    betterlockscreen.enable = true;
    guake.enable = true;

    # Hyprland
    hyprland.enable = true;
    # waybar.enable = true;
    wofi.enable = true;

    # Other
    pentest.enable = true;
  };
}
