{ config, pkgs, ... }: {
  imports = [ ../profiles/base.nix ../users.nix ];

  modules.nixos = {
    qt.enable = true;
    catppuccin.enable = true;
  };

  wsl = {
    enable = true;
    defaultUser = "dreadster";
  };

  networking.hostName = "nixwsl";

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.11";
}
