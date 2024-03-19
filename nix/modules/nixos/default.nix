{ config, lib, pkgs, ... }: {
  imports = [
    ./x11.nix
    ./grub.nix
    ./bspwm.nix
    ./zsh.nix
    ./tlp.nix
    ./xrdp.nix
    ./steam.nix
    ./docker.nix
    ./nvidia.nix
    ./thunar.nix
    ./vmware.nix
    ./flatpak.nix
    ./zerotier.nix
    ./pulseaudio.nix
    ./teamviewer.nix
    ./network.nix
  ];
}
