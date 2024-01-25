{ config, lib, pkgs, ... }: {
  imports = [
    ./nvidia.nix
    ./bspwm.nix
    ./tlp.nix
    ./zsh.nix
    ./wireless.nix
    ./pulseaudio.nix
    ./localization.nix
    ./steam.nix
    ./flatpak.nix
  ];
}
