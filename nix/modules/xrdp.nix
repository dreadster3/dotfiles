{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.xrdp;
in {
  options = { modules.xrdp = { enable = mkEnableOption "xrdp"; }; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xorg.xinit ];

    services.xrdp = {
      enable = true;
      openFirewall = true;
      defaultWindowManager = "exec bspwm";
    };
  };
}
