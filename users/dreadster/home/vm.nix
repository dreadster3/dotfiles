{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = { x11eventcallbacks = { enable = true; }; };
}
