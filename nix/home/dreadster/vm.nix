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
    firefox.enable = true;

    # X11
    polybar = {
      enable = true;
      networkInterface = { name = "ens33"; };
    };
    rofi.enable = true;
    rofi.package = pkgs.rofi;
    # sxhkd.enable = true;
    # bspwm = {
    #   enable = true;
    #   startupPrograms = [
    #     "${pkgs.open-vm-tools}/bin/vmware-user-suid-wrapper"
    #     "${
    #       lib.getExe pkgs.xorg.xrandr
    #     } --output ${primaryMonitor} --primary --pos 1080x240 --output ${secondaryMonitor} --pos 0x0"
    #   ];
    # };
    # flameshot.enable = true;
    # mechvibes.enable = true;
    # x11eventcallbacks.enable = true;
    # betterlockscreen.enable = true;
    # guake.enable = true;

    # Other
    pentest.enable = true;
  };
}
