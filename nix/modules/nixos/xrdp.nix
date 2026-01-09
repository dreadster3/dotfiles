{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.xrdp;
in
{
  options = {
    modules.nixos.xrdp = {
      enable = mkEnableOption "xrdp";
    };
  };

  config = mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      openFirewall = true;
      defaultWindowManager = "${pkgs.bspwm}/bin/bspwm";
    };
  };
}
