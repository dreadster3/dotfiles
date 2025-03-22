{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.sddm;
in {
  options = {
    modules.nixos.sddm = {
      enable = mkEnableOption "sddm";
      package = mkOption {
        type = types.package;
        default = pkgs.kdePackages.sddm;
      };
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      package = cfg.package;
    };
  };
}
