{ config, lib, pkgs, ... }:

{
  users.users.dreadster = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [ ];
  };

  home-manager.users.dreadster = (import ./home/msi.nix);
}
