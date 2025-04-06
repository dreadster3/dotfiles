{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.virtualisation.waydroid.host;
in {
  options = {
    modules.nixos.virtualisation.waydroid.host = {
      enable = mkEnableOption "virtualisation.waydroid.host";
      package = mkOption {
        type = types.package;
        default = pkgs.waydroid;
        description = "The waydroid Tools package to install.";
      };
    };
  };

  config = mkIf cfg.enable { virtualisation.waydroid.enable = true; };
}
