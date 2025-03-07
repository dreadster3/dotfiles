{ inputs, outputs, config, lib, pkgs, ... }:
let
  catppuccinConfig = config.catppuccin;
  mkUpper = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {
  imports = [ ./common.nix ];

  security.pki.certificateFiles = [ ../../../certificates/issuer.crt ];

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
      size = 24;
    };

    fonts = {
      monospace = {
        name = "Mononoki Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = [ "Mononoki" "FiraCode" "VictorMono" "Iosevka" ];
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

    # Disable modules supported by catppuccin
    targets = { grub.enable = false; };
  };

  # Run appimages directly
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nh = {
    enable = true;
    flake = "/home/dreadster/Documents/projects/github/dotfiles/nix";
  };

  environment.systemPackages = with pkgs; [
    eog
    networkmanagerapplet
    openvpn
    clinfo
    postman
  ];

  modules.nixos = {
    catppuccin.enable = true;
    thunar.enable = true;
    network.enable = true;
    sound.enable = true;
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.polkit.enable = true;
}
