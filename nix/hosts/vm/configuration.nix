# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ hostname, config, pkgs, lib, ... }: {
  imports = [
    ../profiles/personal.nix

    ./hardware-configuration.nix
    ./home.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ pocl ];
  };

  modules.nixos = {
    x11.enable = true;
    sddm.enable = true;
    virtualisation.vmware.guest.enable = true;
    wireshark.enable = true;

    ssh.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  # services.displayManager.defaultSession = lib.mkForce "none+i3";

  networking.hostName = hostname;

  system.stateVersion = "23.11";
}
