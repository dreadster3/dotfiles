{ config, pkgs, lib, ... }:

{
  imports = [ ../modules/localization.nix ../modules/zsh.nix ];

  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  programs = { thunar = { enable = true; }; };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    firefox
    wezterm
    kitty
    nitrogen
    zip
    unzip
    xclip
    flameshot
    btop
    procps
    betterlockscreen
  ];
}
