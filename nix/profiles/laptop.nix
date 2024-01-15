{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  modules = {
    tlp = { enable = true; };
    wireless = { enable = true; };
  };
}
