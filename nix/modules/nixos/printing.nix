{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.printing;
in
{
  options = {
    modules.nixos.printing = {
      enable = mkEnableOption "printing";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hplipWithPlugin
      simple-scan
    ];

    services.printing = {
      enable = true;
      drivers = with pkgs; [ hplipWithPlugin ];
    };

    services.avahi = {
      enable = true;
    };

    hardware.sane = {
      enable = true;
      extraBackends = with pkgs; [ hplipWithPlugin ];
    };
  };
}
