{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.xrdp;
in {
  options = { modules.xrdp = { enable = mkEnableOption "xrdp"; }; };

  config = mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      openFirewall = true;
      defaultWindowManager = "${pkgs.bspwm}/bin/bspwm";
    };
  };
}
