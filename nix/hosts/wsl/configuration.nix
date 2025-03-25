{ config, pkgs, ... }: {
  imports = [ ../profiles/base.nix ../users.nix ./home.nix ];

  modules.nixos = {
    qt.enable = true;
    catppuccin.enable = true;
    qmk.enable = true;
  };

  wsl = {
    enable = true;
    defaultUser = "dreadster";
  };

  networking.hostName = "nixwsl";

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.11";
}
