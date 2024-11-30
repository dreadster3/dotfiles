{ inputs, outputs, config, lib, pkgs, ... }:
let
  catppuccinConfig = config.catppuccin;
  mkUpper = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {
  imports = [ ./common.nix ];

  security.pki.certificateFiles = [ ../../../certificates/issuer.crt ];

  stylix.enable = true;

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
    gnome.eog
    networkmanagerapplet
    openvpn
    clinfo
    postman
  ];

  modules.nixos = {
    catppuccin.enable = true;
    thunar.enable = true;
    network.enable = true;
    pipewire.enable = lib.mkDefault true;
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

  security.polkit.enable = true;
}
