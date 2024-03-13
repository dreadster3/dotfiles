{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ./default.nix ];

  modules = { pentest.enable = true; };

  programs.home-manager.enable = true;
}
