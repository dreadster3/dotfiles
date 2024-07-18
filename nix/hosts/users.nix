{ inputs, outputs, lib, config, pkgs, ... }:
with lib; {

  users.users = {
    dreadster = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Admin";
      extraGroups = [ "networkmanager" "wheel" ]
        ++ optional config.virtualisation.docker.enable "docker";
    };
  };

  home-manager.users = { dreadster = import ../../home/dreadster/vm.nix; };
}
