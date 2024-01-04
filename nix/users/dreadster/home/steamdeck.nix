{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ];

  home.stateVersion = "18.09";

  home.packages = with pkgs; [ ranger btop unzip zip xclip ];

  fonts.fontconfig.enable = true;

  modules = {
    dunst = { enable = true; };
    nerdfonts = { enable = true; };
    ranger = { enable = true; };
    zsh = { enable = true; };
    neovim = { enable = true; };
    wezterm = { enable = true; };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    git = {
      enable = true;
      userName = "dreadster3";
      userEmail = "afonso.antunes@live.com.pt";
    };
  };

  programs.home-manager.enable = true;
}
