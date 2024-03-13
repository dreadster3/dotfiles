{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.grub;
in {
  options = { modules.nixos.grub = { enable = mkEnableOption "GRUB"; }; };

  config = mkIf cfg.enable {
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
