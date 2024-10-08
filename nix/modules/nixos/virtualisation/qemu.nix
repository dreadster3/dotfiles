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

    environment.systemPackages = with pkgs; [ glxinfo ];

    services.xserver.videoDrivers = [ "qxl" ];

    specialisation.virgl.configuration = mkIf cfg.opengl {
      nixpkgs.config.cudaSupport = true;

      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };

      services.xserver.videoDrivers = lib.mkForce [ "virgl" ];
    };

  };
}
