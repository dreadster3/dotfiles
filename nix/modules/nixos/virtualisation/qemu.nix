{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.virtualisation.guest.qemu;
in {
  options = {
    modules.nixos.virtualisation.guest.qemu = {
      enable = mkEnableOption "virtualisation.guest.qemu";
      opengl = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    services.spice-vdagentd.enable = true;
    services.spice-autorandr.enable = true;
    services.qemuGuest.enable = true;

    services.xserver.videoDrivers = optional (cfg.opengl) "modesetting"
      ++ [ "qxl" ];
    hardware.opengl.enable = mkIf cfg.opengl true;
  };
}
