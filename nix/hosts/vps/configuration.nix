# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }: {
  imports = [
    ../../profiles/nixos/server.nix
    ./dreadster.nix
    ./coolify.nix

    ./hardware-configuration.nix
  ];

  modules.nixos = {
    grub = {
      device = "/dev/sda";
      useOSProber = false;
    };
    rustdesk = {
      enable = true;
      relayHosts = [ "rustdesk.dreadster3.com" ];
    };
  };

  services.chrony = {
    enable = true;
    servers = [
      "0.europe.pool.ntp.org"
      "1.europe.pool.ntp.org"
      "2.europe.pool.ntp.org"
      "3.europe.pool.ntp.org"
    ];
  };

  networking.hostName = "nixvps";
  system.stateVersion = "23.11";
}
