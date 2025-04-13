{ lib, config, pkgs, ... }:
with lib; {
  users.users.dreadster = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ]
      ++ optional config.virtualisation.docker.enable "docker"
      ++ optional config.programs.wireshark.enable "wireshark"
      ++ optional config.modules.nixos.oryx.enable "plugdev";
  };
}
