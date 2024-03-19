{ config, lib, pkgs, ... }:

{
  users.users.dreadster = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Admin";
    extraGroups = lib.mkBefore [ "networkmanager" "wheel" ]
      ++ lib.lists.optionals config.virtualisation.docker.enable [ "docker" ];
  };
}
