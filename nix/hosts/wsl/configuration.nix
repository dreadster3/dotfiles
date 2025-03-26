{ config, pkgs, ... }: {
  imports = [
    ../../profiles/nixos/base.nix

    ./dreadster.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config.cudaSupport = true;

  environment.sessionVariables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";

    LD_LIBRARY_PATH = [
      "/usr/lib/wsl/lib"
      "${pkgs.linuxPackages.nvidia_x11}/lib"
      "${pkgs.ncurses5}/lib"
    ];
  };

  programs.xwayland.enable = true;

  modules.nixos = {
    qt.enable = true;
    catppuccin.enable = true;
    qmk.enable = true;
    stylix.enable = true;
    wireshark.enable = true;
    nvidia.enable = true;
    thunar.enable = true;
  };

  hardware.graphics.extraPackages = with pkgs; [ pocl ];

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
