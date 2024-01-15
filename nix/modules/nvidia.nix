{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nvidia;
in {
  options = { modules.nvidia = { enable = mkEnableOption "nvidia"; }; };

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
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
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
