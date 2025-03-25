{ config, pkgs, ... }:
let
  catppuccinConfig = config.catppuccin;
  mkUpper = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {
  modules.nixos = {
    grub.enable = true;
    docker.enable = true;
    ssh.enable = true;
  };

  stylix.enable = lib.mkDefault false;
  catppuccin.enable = lib.mkDefault false;
}
