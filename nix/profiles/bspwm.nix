{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  nixpkgs.config.allowUnfree = true;

  programs = { thunar = { enable = true; }; };

  modules = { bspwm = { enable = true; }; };

  environment.systemPackages = with pkgs; [
    nitrogen
    flameshot
    betterlockscreen
  ];
}
