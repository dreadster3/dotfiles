{ inputs, outputs, config, lib, pkgs, pkgs-unstable, ... }:
let
in {
  imports = [ ./default.nix ];

  home.packages = with pkgs; [ remmina ];

  modules.homemanager = {
    settings = {
      monitors = {
        x11 = {
          Virtual1 = {
            primary = true;
            workspaces = [ 1 2 3 4 5 ];
          };
          Virtual2 = { workspaces = [ 6 7 8 9 10 ]; };
        };
      };
    };

    gtk.enable = false;
    dunst.enable = true;

    # X11
    polybar = {
      enable = true;
      networkInterface = { name = "ens33"; };
    };
    rofi.enable = true;
    sxhkd.enable = true;
    bspwm = {
      enable = true;
      startupPrograms =
        [ "${pkgs.open-vm-tools}/bin/vmware-user-suid-wrapper" ];
    };
    flameshot.enable = true;
    mechvibes.enable = true;
    x11eventcallbacks.enable = true;
    picom.enable = true;
    betterlockscreen.enable = true;
    guake.enable = true;

    # Other
    pentest.enable = true;
  };
}
