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
    home-manager.sharedModules = [{
      wayland.windowManager.hyprland.settings.env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
      ];
    }];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [ glxinfo ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = { enable = cfg.enablePrime; };
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
