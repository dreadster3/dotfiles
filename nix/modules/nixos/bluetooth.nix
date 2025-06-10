{ lib, config, ... }:
with lib;
let cfg = config.modules.nixos.bluetooth;
in {
  options = {
    modules.nixos.bluetooth = { enable = mkEnableOption "bluetooth"; };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services.blueman.enable = true;
  };
}
