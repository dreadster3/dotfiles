# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ hostname, config, pkgs, ... }: {
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
    i3.enable = true;
    sddm.enable = true;

    ssh.enable = true;
  };

  networking.hostName = hostname;

  services.xserver.videoDrivers = [ "vmware" ];
  virtualisation.vmware.guest.enable = true;
  xsession.windowManager.i3.config.startup = [{
    command =
      "${config.virtualisation.vmware.guest.package}/bin/vmware-user-suid-wrapper";
    always = true;
    notification = false;
  }];

  system.stateVersion = "23.11";
}
