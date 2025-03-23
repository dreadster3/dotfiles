{ inputs, outputs, config, lib, pkgs, pkgs-unstable, ... }:
let primaryMonitor = "Virtual1";
in {
  imports = [ ./base/personal.nix ];

  home.packages = with pkgs; [ remmina ];

  modules.homemanager = {
    settings = {
      monitors = {
        x11 = {
          "${primaryMonitor}" = {
            primary = true;
            workspaces = [ 1 2 3 4 5 ];
          };
        };
      };
    };

    gtk.enable = true;
    dunst.enable = true;

    # X11
    polybar = {
      enable = true;
      networkInterface = { name = "ens33"; };
    };
    rofi = {
      enable = true;
      package = pkgs.rofi;
    };
    flameshot.enable = true;
    x11eventcallbacks.enable = true;

    pentest.enable = true;
  };
}
