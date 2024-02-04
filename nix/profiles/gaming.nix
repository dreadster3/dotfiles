{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  environment.systemPackages = with pkgs; [
    kazam
    haruna
    mpv
    wineWowPackages.stable
    winetricks
  ];

  modules = { steam = { enable = true; }; };
}
