{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.qmk;
in {
  options = {
    modules.nixos.qmk = {
      enable = mkEnableOption "qmk";
      package = mkOption {
        type = types.package;
        default = pkgs.qmk;
        description = "The package to install.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ cfg.package via ];
    services.udev.packages = [ pkgs.via ];
    hardware.keyboard.qmk.enable = true;
    services.udev.extraRules = ''
      # AT32 DFU
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", TAG+="uaccess"
    '';
  };
}
