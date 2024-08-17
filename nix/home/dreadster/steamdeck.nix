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

  stylix = {
    enable = true;
    image = ../../../wallpapers/furina.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      name = "catppuccin-mocha-blue-cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
      size = 32;
    };

    fonts = {
      monospace = {
        name = "FiraCode Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = [ "FiraCode" "VictorMono" "Iosevka" ];
        };
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;

      sizes = {
        terminal = 18;
        desktop = 12;
      };
    };
  };

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
