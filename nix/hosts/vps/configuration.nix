# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ../profiles/server.nix

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
    grub = {
      device = "/dev/sda";
      useOSProber = false;
    };
  };

  users.groups.coolify = { gid = 9999; };
  users.users.coolify = {
    isSystemUser = true;
    hashedPassword = "!";
    group = "coolify";
    uid = 9999;
  };

  networking.hostName = "nixvps";

  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  system.stateVersion = "23.11";
}
