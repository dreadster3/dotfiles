{ config, lib, pkgs, ... }: {
  imports = [
    ./rofi
    ./gtk.nix
    ./zsh.nix
    ./neovim.nix
    ./polybar.nix
    ./nerdfonts.nix
    ./x11eventcallbacks.nix
    ./kitty.nix
    ./sxhkd.nix
    ./bspwm.nix
    ./btop.nix
    ./picom.nix
    ./wezterm.nix
    ./ranger.nix
    ./dunst.nix
    ./betterlockscreen.nix
    ./fusuma.nix
    ./xbindkeys.nix
  ];
}
