{ config, lib, pkgs, ... }: {
  imports = [
    ./openrgb.nix
    ./x11.nix
    ./grub.nix
    ./bspwm.nix
    ./zsh.nix
    ./powermanagement.nix
    ./xrdp.nix
    ./steam.nix
    ./docker.nix
    ./nvidia.nix
    ./thunar.nix
    ./flatpak.nix
    ./zerotier.nix
    ./teamviewer.nix
    ./network.nix
    ./kubernetes.nix
    ./ssh.nix
    ./sound.nix
    ./nightlight.nix
    ./storage.nix
    ./hyprland.nix
    ./catppuccin.nix
    ./fail2ban.nix
    ./rustdesk.nix
    ./qmk.nix
    ./oryx.nix
    ./xfce.nix
    ./i3.nix
    ./sddm.nix
    ./virtualisation
    ./wireshark.nix
    ./qt.nix
    ./stylix.nix
    ./aio.nix
    ./nerdfonts.nix
    ./printing.nix
    ./bluetooth.nix
    ./mobile.nix
    ./archive.nix
  ];
}
