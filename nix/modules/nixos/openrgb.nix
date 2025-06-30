{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.openrgb;
in {
  options = {
    modules.nixos.openrgb = {
      enable = mkEnableOption "openrgb";
      package = mkOption {
        type = types.package;
        default = pkgs.openrgb;
        description = "The package to install.";
      };
    };
  };

  config = mkIf cfg.enable {
    services.hardware.openrgb = {
      inherit (cfg) package;
      enable = true;
    };

    hardware.i2c.enable = true;
  };
}
