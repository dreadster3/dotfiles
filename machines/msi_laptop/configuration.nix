# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in {
  imports = [
    # Include the results of the hardware scan.
    ../../profiles/common.nix
    ../../profiles/bspwm.nix
    ../../profiles/nvidia.nix
    ../../profiles/powermanagement.nix
    ../../profiles/pulseaudio.nix
    ../../users/dreadster/msi.nix
    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot = {
    loader = {
      efi = { canTouchEfiVariables = true; };
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
    };
  };

  networking.hostName = "MSILinux";
  networking.networkmanager.enable = true;

  services.udev = {
    enable = true;
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils-full}/bin/chgrp video /sys/class/backlight/intel_backlight/brightness", RUN+="${pkgs.coreutils-full}/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness"
    '';
  };

  system.stateVersion = "23.05";
}
