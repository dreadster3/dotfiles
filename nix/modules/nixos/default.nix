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
    ./vmware.nix
    ./flatpak.nix
    ./zerotier.nix
    ./pulseaudio.nix
    ./teamviewer.nix
    ./network.nix
    ./kubernetes.nix
    ./ssh.nix
    ./pipewire.nix
    ./nightlight.nix
    ./storage.nix
    ./hyprland.nix
    ./virtualisation

    # TODO: Remove when this gets fixed upstream
    ./regreet.nix
  ];
}
