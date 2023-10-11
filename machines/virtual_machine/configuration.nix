# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
	  ../../profiles/common.nix
	  ../../profiles/bspwm.nix
	  ../../users/dreadster/base.nix
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
	  };
  };

  networking.hostName = "nixosvm";

  virtualisation.vmware.guest.enable = true;

  system.stateVersion = "23.05";
}
