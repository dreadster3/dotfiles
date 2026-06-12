# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ../../profiles/nixos/personal.nix
    ./dreadster.nix

    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    vlc
    libvlc
    ddcutil
    goverlay

    linuxPackages.usbip
    moonlight-qt
  ];

  # Disable usb autosuspend
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  boot.kernelModules = [
    "usbip-core"
    "usbip-host"
  ];

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
    wireshark.enable = true;
    bluetooth.enable = true;
    mobile.enable = true;
    wireguard.enable = true;
    libreoffice.enable = true;
    netbird.enable = true;
    zerotier.enable = false;
    nfs.enable = true;
    llama-cpp.enable = true;

    virtualisation = {
      qemu.host.enable = true;
      # vmware.host.enable = true;
      waydroid.host.enable = true;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    printing.enable = true;
  };

  networking = {
    hostName = "nixos-desktop";
    hosts = {
      "127.0.0.1" = [
        "log-upload-os.hoyoverse.com"
        "overseauspider.yuanshen.com"
      ];
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

  # GPUtil (used for NVIDIA GPU stats) shells out to `nvidia-smi`, which isn't
  # on the service's PATH by default. Add it so GPU monitoring actually works.
  systemd.services.turing-smart-screen-python.path = [
    config.hardware.nvidia.package.bin
  ];

  services.turing-smart-screen-python = {
    enable = true;
    stopOnSleep = true;
    startOnResume = true;
    fonts = with pkgs.tsspPackages.resources.fonts; [
      geforce
      generale-mono
      jetbrains-mono
      racespace
      roboto
      roboto-mono
    ];
    themes =
      with pkgs.tsspPackages.resources.themes;
      [
        NZXT_C
        LandscapeModernDevice35
      ]
      ++ (with pkgs.tssp-custom-themes; [
        CatppuccinMinimal35
      ]);
    settings = {
      config = {
        COM_PORT = "AUTO";
        THEME = "CatppuccinMinimal35";
        HW_SENSORS = "PYTHON";
        ETH = "eno1";
        WLO = "wlp0s20f3";
        CPU_FAN = "AUTO";
      };
      display = {
        REVISION = "A";
        BRIGHTNESS = 20;
        DISPLAY_REVERSE = false;
      };
    };
  };

  system.stateVersion = "23.11";
}
