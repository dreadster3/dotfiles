# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ../profiles/personal.nix

    ./hardware-configuration.nix
    ./home.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-ocl
      intel-compute-runtime
      intel-media-driver
    ];
  };

  modules.nixos = {
    x11.enable = true;
    bspwm.enable = true;
    # kubernetes.enable = true;
    ssh.enable = true;
    pulseaudio.enable = false;
  };

  networking.hostName = "nixosvm";

  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  system.stateVersion = "23.11";
}
