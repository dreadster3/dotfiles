{ config, pkgs, lib, ... }: with lib; { imports = [ ./qemu.nix ]; }
