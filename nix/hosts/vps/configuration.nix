# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ../profiles/server.nix
    ../users.nix
    ./home.nix

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

  users.groups.coolify = { gid = 9999; };
  users.users.coolify = {
    shell = pkgs.bash;
    isSystemUser = true;
    hashedPassword = "!";
    group = "coolify";
    uid = 9999;
    extraGroups = [ "docker" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEIlwnL7LOKNAGPCQvoaHcIwWi600lwQmeiY8fu56JQ6 coolify@nixvps"
    ];
  };

  networking.hostName = "nixvps";

  system.stateVersion = "23.11";
}
