# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ../../profiles/nixos/personal.nix
    ./dreadster3.nix

    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [ vlc libvlc ];

  # Bootloader.
  modules.nixos = {
    openrgb.enable = true;
    x11.enable = true;
    nightlight.enable = true;
    flatpak.enable = true;
    nvidia.enable = true;
    steam.enable = true;
    teamviewer.enable = true;
    xrdp.enable = true;
    oryx.enable = true;
    qmk.enable = true;
    zerotier.enable = true;

    virtualisation = {
      qemu.host.enable = true;
      vmware.host.enable = true;
      waydroid.host.enable = true;
    };
    hyprland.enable = true;
  };

  programs.adb.enable = true;

  networking.hostName = "nixos-desktop";
  networking.interfaces.eno1.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };

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
