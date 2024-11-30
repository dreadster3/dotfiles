{ inputs, outputs, config, lib, pkgs, ... }:
let
  catppuccinConfig = config.catppuccin;
  mkUpper = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules
    ../users.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [ wget vim git curl unzip zip ];

  modules.nixos = {
    grub.enable = true;
    ssh.enable = true;
    zsh.enable = true;
    storage.enable = true;
  };

  networking.firewall.enable = true;

  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";
  services.locate.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = [ ];
  };

  nix = {
    settings = {
      trusted-users = [ "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  stylix = {
    enable = lib.mkDefault false;
    image = ../../wallpapers/furina.jpg;
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
  catppuccin.enable = lib.mkDefault false;

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
  home-manager.backupFileExtension = "bkp";
  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}
