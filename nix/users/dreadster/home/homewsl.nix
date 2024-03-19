{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ./default.nix ];

  # Enable experimental nix features
  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  modules.homemanager = {
    zsh = {
      enable = true;
      sourceNix = true;
    };
    pentest.enable = true;
  };

  programs.home-manager.enable = true;
}
