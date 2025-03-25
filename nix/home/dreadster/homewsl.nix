{ config, lib, pkgs, ... }: {
  imports = [ ./base/personal.nix ];

  modules.homemanager = { pentest.enable = true; };

  programs.home-manager.enable = true;
}
