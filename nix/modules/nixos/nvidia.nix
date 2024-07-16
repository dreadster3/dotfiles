{ pkgs, pkgs-unstable, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.nvidia;
in {
  options = {
    modules.nixos.nvidia = {
      enable = mkEnableOption "nvidia";
      enablePrime = mkEnableOption "nvidia.prime";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.cudaSupport = true;

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [ glxinfo ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = { enable = true; };
      # forceFullCompositionPipeline = true;
      prime = mkIf cfg.enablePrime {
        sync.enable = true;
        # offload = {
        #   enable = true;
        #   enableOffloadCmd = true;
        # };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
