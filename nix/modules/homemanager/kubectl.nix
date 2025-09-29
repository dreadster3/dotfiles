{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.kubectl;
in {
  options = {
    modules.homemanager.kubectl = {
      enable = mkEnableOption "kubectl";
      package = mkOption {
        type = types.package;
        default = pkgs.kubectl;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ cfg.package kubernetes-helm istioctl ];

    modules.homemanager = {
      k9s.enable = true;
      krew.enable = true;
    };
  };
}
