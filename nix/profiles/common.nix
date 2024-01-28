{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  programs = { nm-applet.enable = true; };

  services = { gvfs.enable = true; };

  security.polkit.enable = true;

  modules = {
    localization = { enable = true; };
    pulseaudio = { enable = true; };
    thunar = { enable = true; };
    zsh = { enable = true; };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    firefox
    wezterm
    kitty
    zip
    unzip
    xclip
    btop
    procps

    vulnix

    polkit_gnome

    # Calculator
    qalculate-gtk
  ];
}
