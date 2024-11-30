{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.grub;
in {
  options = {
    modules.nixos.grub = {
      enable = mkEnableOption "GRUB";
      device = mkOption {
        type = types.str;
        default = "nodev";
      };
      useOSProber = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      grub = {
        enable = true;
        device = cfg.device;
        efiSupport = cfg.device == "nodev";
        useOSProber = cfg.useOSProber;
        default = "saved";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
