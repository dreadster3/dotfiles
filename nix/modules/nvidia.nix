{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nvidia;
in {
  options = {
    modules.nvidia = {
      enable = mkEnableOption "nvidia";
      enablePrime = mkEnableOption "nvidia.prime";
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [ glxinfo ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement = { enable = true; };
      # forceFullCompositionPipeline = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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
