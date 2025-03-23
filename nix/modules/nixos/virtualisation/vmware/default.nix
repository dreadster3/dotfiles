{ config, lib, pkgs, ... }: { imports = [ ./guest.nix ./host.nix ]; }
