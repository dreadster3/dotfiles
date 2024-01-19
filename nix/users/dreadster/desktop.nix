{ config, lib, pkgs, ... }:

{
  imports = [ ./base.nix ];

  home-manager.users.dreadster = { imports = [ ./home/desktop.nix ]; };
}
