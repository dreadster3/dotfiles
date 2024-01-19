{ config, lib, pkgs, ... }: {
  imports = [ ./default.nix ];

  modules = {
    waybar = { enable = true; };
    wofi = { enable = true; };
    hyprland = { enable = true; };
    gtk = {
      enable = true;
      cursor = { enable = true; };
    };
    guake = { enable = true; };
    dunst = { enable = true; };
  };
}
