{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  modules = {
    teamviewer.enable = true;
    zerotier.enable = true;
    xrdp.enable = true;
  };
}
