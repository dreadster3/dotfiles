{ lib, config, ... }:
with lib;
let
  cfg = config.modules.nixos.bluetooth;
in
{
  options = {
    modules.nixos.bluetooth = {
      enable = mkEnableOption "bluetooth";
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    services.udev.extraRules = ''
      # Sony PlayStation DualShock 4; Bluetooth; USB
      ACTION!="remove", KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0660", TAG+="uaccess"
      ACTION!="remove", KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0660", TAG+="uaccess"
    '';
    services.blueman.enable = true;
  };
}
