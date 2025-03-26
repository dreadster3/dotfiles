{ inputs, outputs, config, lib, pkgs, pkgs-unstable, ... }: {
  imports = [ ./base/server.nix ];

  home.stateVersion = "23.11";
}
