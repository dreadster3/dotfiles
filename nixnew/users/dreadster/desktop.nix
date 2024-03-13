{ config, lib, pkgs, ... }:

{
  imports = [ ./base.nix ];

  users.users.dreadster = {
    extraGroups = [ "networkmanager" "wheel" "mlocate" "docker" ];
  };
}
