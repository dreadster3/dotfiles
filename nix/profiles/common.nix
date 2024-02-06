{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  programs = { nm-applet.enable = true; };

  services = {
    gvfs.enable = true;
    locate = {
      enable = true;
      package = pkgs.mlocate;
      localuser = null;
    };
  };

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

    teams-for-linux
    openvpn
    remmina

    vulnix
    cifs-utils

    # Ask for password when needed
    polkit_gnome

    # Calculator
    qalculate-gtk
  ];
}
