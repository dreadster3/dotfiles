{ lib, ... }: {
  imports = [ ./base.nix ];

  modules.nixos = {
    grub.enable = true;
    docker.enable = true;
    ssh.enable = true;
  };

  stylix.enable = lib.mkDefault false;
  catppuccin.enable = lib.mkDefault false;
}
