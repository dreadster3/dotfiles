{ config, lib, pkgs, ... }: {
  imports = [ ./x11.nix ./grub.nix ./bspwm.nix ./zsh.nix ];
}
