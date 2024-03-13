{ config, lib, pkgs, ... }:
let
  catppuccinpkg = pkgs.catppuccin-gtk.override {
    variant = "mocha";
    accents = [ "blue" ];
  };
in {
  imports = [ ../../../modules/homemanager ./default.nix ];

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

  modules = {
    dunst = { enable = true; };
    guake = { enable = true; };
    obsmic = { enable = true; };
  };

  programs.home-manager.enable = true;
}
