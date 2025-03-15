{ inputs, outputs, lib, config, pkgs, ... }:
with lib; {

  users.users = {
    root.hashedPassword = "!";
    dreadster = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Admin";
      extraGroups = [ "networkmanager" "wheel" "adbusers" ]
        ++ optional config.virtualisation.docker.enable "docker";
    };
  };
}
