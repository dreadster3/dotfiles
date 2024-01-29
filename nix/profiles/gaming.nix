{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  environment.systemPackages = with pkgs; [ wineWowPackages.stable ];

  modules = { steam = { enable = true; }; };
}
