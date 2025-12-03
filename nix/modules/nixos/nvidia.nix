{ pkgs, pkgs-unstable, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.nvidia;
in {
  options = { modules.nixos.nvidia = { enable = mkEnableOption "nvidia"; }; };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };

    home-manager.sharedModules = [{
      wayland.windowManager.hyprland.settings.env =
        mkIf config.programs.hyprland.enable [
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct"
          "__GL_VRR_ALLOWED,0"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];
    }];
  };
}
