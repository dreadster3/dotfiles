# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in {
  imports = [
    ../common.nix

    ../../modules/nixos

    /etc/nixos/hardware-configuration.nix
  ];

  modules.nixos = {
    grub.enable = true;
    x11.enable = true;
    bspwm.enable = true;
    zsh.enable = true;
  };

  networking.hostName = "nixosvm";

  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  system.stateVersion = "23.11";
}
