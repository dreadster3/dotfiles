{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  modules = {
    teamviewer.enable = true;
    xrdp.enable = true;
  };
}
