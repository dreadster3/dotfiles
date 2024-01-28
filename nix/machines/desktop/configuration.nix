# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in {
  imports = [ # Include the results of the hardware scan.
    ../../profiles/common.nix
    ../../profiles/nvidia.nix
    ../../profiles/entertainment.nix
    ../../profiles/gaming.nix
    ../../profiles/bspwm.nix
    ../../users/dreadster/desktop.nix
    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "nixos-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver = { xkbVariant = ""; };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Suspend on idle
  services.logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=15min
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    vim
    firefox
    git
    curl
    kitty

    # Controlling RGB devices
    openrgb

    # Wayland apps
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
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
    enableNvidiaPatches = true;
  };

  environment.sessionVariables = { };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  modules = {
    vmware.enable = true;
    zerotier.enable = true;
  };

  # List services that you want to enable:

  # Enable onedrive
  services.onedrive.enable = true;

  # Enable openrgb
  services.hardware.openrgb = { enable = true; };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = { enable = true; };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}