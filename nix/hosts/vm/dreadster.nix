{ inputs, outputs, config, lib, pkgs, pkgs-unstable, ... }:
let primaryMonitor = "Virtual1";
in {

  imports = [ ../users.nix ];

  home-manager.users.dreadster = {
    imports = [ ../../profiles/homemanager/personal.nix ];

    home.packages = with pkgs; [ remmina openvpn warp-terminal ];

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
      flameshot.enable = true;
      x11eventcallbacks.enable = true;

      picom.enable = false;

      pentest.enable = true;
    };

    home.stateVersion = "23.11";
  };
}
