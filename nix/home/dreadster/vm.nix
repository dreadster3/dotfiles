{ inputs, outputs, config, lib, pkgs, pkgs-unstable, ... }:
let
  primaryMonitor = "Virtual1";
  secondaryMonitor = "Virtual2";

  terminal = pkgs.alacritty;
in {
  imports = [ ./default.nix ];

  home.packages = with pkgs; [ remmina ];

  modules.homemanager = {
    nerdfonts.package = pkgs.unstable.nerdfonts;
    gtk.enable = true;
    dunst.enable = true;

    # X11
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
        "${pkgs.open-vm-tools}/bin/vmware-user-suid-wrapper"
        "MONITOR='${primaryMonitor}' ${pkgs.polybar}/bin/polybar main"
      ];
    };
    flameshot.enable = true;
    mechvibes.enable = true;
    x11eventcallbacks.enable = true;
    picom.enable = true;
    betterlockscreen.enable = true;
    guake.enable = true;
    neovim = {
      enable = true;
      package = pkgs.unstable.neovim-unwrapped;
      go = pkgs.unstable.go;
    };

    # Other
    pentest.enable = true;
  };
}
