# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ../../profiles/nixos/personal.nix
    ./dreadster3.nix

    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    vlc
    libvlc
    quickshell
    ddcutil
    goverlay

    linuxPackages.usbip
    moonlight-qt
  ];

  # Disable usb autosuspend
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  boot.kernelModules = [ "usbip-core" "usbip-host" ];

  # Bootloader.
  modules.nixos = {
    aio.enable = true;
    openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
    nightlight.enable = true;
    flatpak.enable = true;
    nvidia.enable = true;
    steam.enable = true;
    teamviewer.enable = false;
    oryx.enable = true;
    qmk.enable = true;
    zerotier.enable = true;
    wireshark.enable = true;
    bluetooth.enable = true;
    mobile.enable = true;
    wireguard.enable = true;
    nfs.enable = true;

    virtualisation = {
      qemu.host.enable = true;
      # vmware.host.enable = true;
      waydroid.host.enable = true;
    };
    hyprland.enable = true;
    printing.enable = true;
  };

  programs.adb.enable = true;

  networking = {
    hostName = "nixos-desktop";
    hosts = {
      "127.0.0.1" =
        [ "log-upload-os.hoyoverse.com" "overseauspider.yuanshen.com" ];
    };
  };
  networking.interfaces.eno1.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };

  # Suspend on idle
  services = {
    logind.settings.Login = {
      IdleAction = "suspend";
      IdleActionSec = "15min";
    };

    onedrive.enable = true;
    flatpak.enable = true;
  };

  system.stateVersion = "23.11";
}
