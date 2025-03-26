{ config, pkgs, ... }: {
  imports = [
    ../profiles/base.nix
    ../users.nix
    ./home.nix

    ./hardware-configuration.nix
  ];

  modules.nixos = {
    qt.enable = true;
    catppuccin.enable = true;
    qmk.enable = true;
    stylix.enable = true;
    wireshark.enable = true;
  };

  wsl = {
    enable = true;
    defaultUser = "dreadster";
    useWindowsDriver = true;
    startMenuLaunchers = true;
  };

  networking.hostName = "nixwsl";

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.11";
}
