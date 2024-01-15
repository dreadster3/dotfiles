{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  modules = { nvidia = { enable = true; }; };
}
