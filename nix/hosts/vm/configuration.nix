# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ hostname, config, pkgs, lib, ... }: {
  imports = [
    ../../profiles/nixos/personal.nix
    ./dreadster.nix

    ./hardware-configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ pocl ];
  };

  modules.nixos = {
    x11.enable = true;
    i3.enable = true;
    sddm.enable = true;
    virtualisation.vmware.guest.enable = true;
    wireshark.enable = true;
  };

  networking.hostName = hostname;

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.11";
}
