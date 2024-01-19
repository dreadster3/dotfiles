{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  environment.systemPackages = with pkgs; [ wineWowPackages.waylandFull ];

  modules = { steam = { enable = true; }; };
}
