{ ... }: {
  imports = [
    ./settings.nix

    ./zsh.nix
    ./alacritty.nix
    ./kitty.nix
    ./sxhkd.nix
    ./nerdfonts.nix
    ./neovim.nix
    ./bspwm.nix
    ./aio.nix
    ./gtk.nix
    ./btop.nix
    ./wofi
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
    ./xbindkeys.nix
    ./thunderbird.nix
    ./betterlockscreen.nix
    ./tmux.nix
    ./flameshot.nix

    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./swaylock.nix
    ./swayidle.nix
    ./wlogout

    ./mechvibes
    ./x11eventcallbacks
    ./rofi
    ./spicetify
    ./obsmic
  ];

  nixpkgs.config.allowUnfree = true;
}
