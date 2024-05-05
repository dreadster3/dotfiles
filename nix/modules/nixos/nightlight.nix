{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.nixos.nightlight;
  locations = {
    "portugal" = {
      latitude = 38.7;
      longitude = -9.2;
    };
  };
in {
  options = {
    modules.nixos.nightlight = {
      enable = mkEnableOption "nightlight";

      location = mkOption {
        type = with types; types.enum [ "portugal" ];
        default = "portugal";
      };
    };
  };
  config = mkIf cfg.enable {
    location = {
      provider = "manual";
      latitude = locations.${cfg.location}.latitude;
      longitude = locations.${cfg.location}.longitude;
    };
    services.redshift = {
      enable = true;
      temperature = {
        day = 5500;
        night = 3700;
      };
    };
  };
}
