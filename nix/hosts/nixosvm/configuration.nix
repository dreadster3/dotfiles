# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ../common.nix

    ./hardware-configuration.nix
    ./home.nix
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # Necessary for hashcat
      intel-ocl
      intel-compute-runtime
      intel-media-driver
    ];
  };

  modules.nixos = {
    x11.enable = true;
    bspwm.enable = true;
    kubernetes.enable = true;
    docker.enable = true;
    ssh.enable = true;
    pipewire.enable = false;
    pulseaudio.enable = true;
  };

  networking.hostName = "nixosvm";

  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  system.stateVersion = "23.11";
}
