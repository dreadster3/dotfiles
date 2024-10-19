{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

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
      name = "catppuccin-mocha-blue-cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
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

  modules.homemanager = {
    zsh = {
      enable = true;
      sourceNix = true;
    };
    pentest.enable = true;
  };

  programs.home-manager.enable = true;
}
