{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.aio;
in
{
  options = {
    modules.nixos.aio = {
      enable = mkEnableOption "aio";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lm_sensors
      liquidctl
    ];

    programs.coolercontrol.enable = true;
  };
}
