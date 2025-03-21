# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ../profiles/personal.nix

    ./hardware-configuration.nix
    ./home.nix
  ];

  boot.kernelParams = [ "acpi_osi=!" ''acpi_osi="Windows 2009"'' ];

  environment.systemPackages = with pkgs; [ vlc libvlc ];

  # Bootloader.
  modules.nixos = {
    x11.enable = true;
    nightlight.enable = true;
    bspwm.enable = true;
    flatpak.enable = true;
    nvidia = {
      enable = true;
      enablePrime = true;
    };
    docker.enable = true;
    steam.enable = true;
    teamviewer.enable = true;
    vmware.enable = true;
    xrdp.enable = true;
    ssh.enable = true;
    zerotier.enable = true;

    powermanagement.enable = true;

    hyprland.enable = true;
  };

  networking.hostName = "nixos-laptop";

  # Suspend on idle
  services.logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=15min
  '';

  # List services that you want to enable:
  # Enable onedrive
  services.onedrive.enable = true;

  system.stateVersion = "23.11";
}
