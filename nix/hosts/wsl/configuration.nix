{ config, pkgs, ... }: {
  imports = [ ../profiles/base.nix ../users.nix ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

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
