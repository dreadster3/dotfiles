{ config, lib, pkgs, ... }:
let
  catppuccinpkg = pkgs.catppuccin-gtk.override {
    variant = "mocha";
    accents = [ "blue" ];
  };
in {
  imports = [ ../../../modules/homemanager ./default.nix ];

  home.username = "deck";
  home.homeDirectory = "/home/deck";

  home.packages = with pkgs; [
    droidcam
    openvpn
    betterdiscordctl
    catppuccinpkg
    catppuccin-cursors.mochaBlue
    unzip
    zip
    xclip
  ];

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
    # wezterm.enable = true;
    kitty.enable = lib.mkForce false;
    dunst.enable = true;
    guake.enable = true;
    obsmic.enable = true;
  };

  programs.home-manager.enable = true;
}
