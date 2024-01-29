{ config, lib, pkgs, ... }:

{
  imports = [ ./base.nix ];

  users.users.dreadster = {
    extraGroups = lib.mkForce [ "networkmanager" "wheel" "mlocate" ];
  };

  home-manager.users.dreadster = { imports = [ ./home/desktop.nix ]; };
}
