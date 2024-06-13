{ ... }: {
  imports = [
    ./zsh.nix
    ./kitty.nix
    ./sxhkd.nix
    ./nerdfonts.nix
    ./neovim.nix
    ./bspwm.nix
    ./aio.nix
    ./gtk.nix
    ./btop.nix
    ./wofi.nix
    ./dunst.nix
    ./guake.nix
    ./helix.nix
    ./picom.nix
    ./tint2.nix
    ./fusuma.nix
    ./ranger.nix
    ./waybar.nix
    ./pentest.nix
    ./polybar.nix
    ./wezterm.nix
    ./hyprland.nix
    ./xbindkeys.nix
    ./thunderbird.nix
    ./betterlockscreen.nix
    ./tmux.nix

    ./mechvibes
    ./x11eventcallbacks
    ./rofi
    ./spicetify
    ./obsmic
  ];

  nixpkgs.config.allowUnfree = true;
}
