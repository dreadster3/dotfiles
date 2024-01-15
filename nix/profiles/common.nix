{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  programs = {
    thunar = { enable = true; };
    nm-applet = { enable = true; };
  };

  modules = {
    localization = { enable = true; };
    pulseaudio = { enable = true; };
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
  ];
}
