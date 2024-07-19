{ inputs, outputs, config, lib, pkgs, pkgs-unstable, ... }:
let
  terminal = pkgs.alacritty;

  monitors = {
    Virtual1 = {
      default = true;
      workspaces = [ 1 2 3 4 5 ];
    };
    Virtual2 = { workspaces = [ 6 7 8 9 10 ]; };
  };
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
      monitors = monitors;
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
      monitors = monitors;
      startupPrograms =
        [ "${pkgs.open-vm-tools}/bin/vmware-user-suid-wrapper" ];
    };
    flameshot.enable = true;
    mechvibes.enable = true;
    x11eventcallbacks.enable = true;
    picom.enable = true;
    betterlockscreen.enable = true;
    guake.enable = true;
    neovim.terminal = terminal;

    # Other
    pentest.enable = true;
  };
}
