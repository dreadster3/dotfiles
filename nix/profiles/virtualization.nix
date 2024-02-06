{ config, pkgs, lib, ... }:

{
  imports = [ ../modules ];

  modules = {
    docker.enable = true;
    vmware.enable = true;
  };
}
