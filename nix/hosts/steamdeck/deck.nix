{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ../../profiles/homemanager/personal.nix ];

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  home = {
    username = "deck";
    homeDirectory = "/home/deck";
    packages = with pkgs; [
      droidcam
      openvpn
      betterdiscordctl
      unzip
      zip
      xclip

      # Fonts
      nerd-fonts.victor-mono
      nerd-fonts.fira-code
      nerd-fonts.mononoki
    ];
  };

  stylix = {
    enable = true;
    image = ../../../wallpapers/skirk.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      monospace = {
        name = "Mononoki Nerd Font";
        package = pkgs.nerd-fonts.mononoki;
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

  xdg.mimeApps.enable = false;

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
