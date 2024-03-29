# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in {
  imports = [ # Include the results of the hardware scan.
    ../common.nix

    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  modules.nixos = {
    x11.enable = true;
    bspwm.enable = true;
    nvidia.enable = true;
    docker.enable = true;
    steam.enable = true;
    teamviewer.enable = true;
    vmware.enable = true;
    xrdp.enable = true;
    zerotier.enable = true;
  };

  networking.hostName = "nixos-desktop";

  # Suspend on idle
  services.logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=15min
  '';

  # List services that you want to enable:
  # Enable onedrive
  services.onedrive.enable = true;

  # Enable openrgb
  services.hardware.openrgb = { enable = true; };
  services.ratbagd.enable = true;
  # Enable the OpenSSH daemon.
  services.sshguard.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
    };
  };

  system.stateVersion = "23.11";

}
