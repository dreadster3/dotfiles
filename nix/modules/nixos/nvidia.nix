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
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [
      glxinfo
      pkgs-unstable.cudaPackages.cudatoolkit
      linuxPackages.nvidia_x11
    ];

    environment.sessionVariables = {
      CUDA_PATH = "${pkgs-unstable.cudaPackages.cudatoolkit}";
    };

    systemd.services.nvidia-control-devices = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart =
        "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
    };

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
