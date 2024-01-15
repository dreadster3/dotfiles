{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ];

  home.stateVersion = "18.09";

  home.packages = with pkgs; [ killall ];

  nixpkgs.config.allowUnfree = true;

  # Custom modules
  modules = {
    nerdfonts = { enable = true; };
    kitty = { enable = true; };
    btop = { enable = true; };
    wezterm = { enable = true; };
    neovim = { enable = true; };
    ranger = { enable = true; };
    zsh = { enable = true; };
  };

  programs = {
    git = {
      enable = true;
      userName = "dreadster3";
      userEmail = "afonso.antunes@live.com.pt";
    };
  };
}
