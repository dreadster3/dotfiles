{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ./default.nix ];

  programs.home-manager.enable = true;
}
