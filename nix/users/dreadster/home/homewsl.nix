{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ./default.nix ];

  modules.homemanager = { pentest.enable = true; };

  programs.home-manager.enable = true;
}
