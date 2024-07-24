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
      enable = true;
      package = cfg.package;
    };
  };
}
