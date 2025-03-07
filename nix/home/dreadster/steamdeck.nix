{ config, lib, pkgs, ... }:
let
  catppuccinConfig = config.catppuccin;
  mkUpper = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {

  imports = [ ./profiles/personal.nix ];

  # Enable experimental nix features
  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  stylix = {
    enable = true;
    image = ../../../wallpapers/furina.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      name =
        "catppuccin-${catppuccinConfig.flavor}-${catppuccinConfig.accent}-cursors";
      package = pkgs.catppuccin-cursors."${catppuccinConfig.flavor}${
          mkUpper catppuccinConfig.accent
        }";
      size = 32;
    };

    fonts = {
      monospace = {
        name = "Mononoki Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = [ "FiraCode" "Mononoki" "VictorMono" "Iosevka" ];
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

  home.username = "deck";
  home.homeDirectory = "/home/deck";

  home.packages = with pkgs; [
    droidcam
    openvpn
    betterdiscordctl
    unzip
    zip
    xclip
  ];

  fonts.fontconfig.enable = true;

  modules.homemanager = {
    catppuccin = {
      enable = true;
      accent = "mauve";
    };
    zsh.sourceNix = true;
    alacritty.package = pkgs.emptyDirectory;
    dunst.enable = true;
    obsmic.enable = true;
    pentest.enable = true;
  };

  programs.home-manager.enable = true;
}
