# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in {
  imports = [
    # Include the results of the hardware scan.
    ../../profiles/common.nix
    ../../profiles/bspwm.nix
    ../../users/dreadster/vm.nix
    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };

  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    vim
    firefox
    git
    curl
    kitty
    alacritty
    foot

    piper

    # Wayland apps
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    networkmanagerapplet
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # services.dbus.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals =
  #     [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
  # };

  networking.hostName = "nixosvm";

  virtualisation.vmware.guest.enable = true;

  services.xserver.videoDrivers = [ "vmware" ];

  system.stateVersion = "23.11";
}
