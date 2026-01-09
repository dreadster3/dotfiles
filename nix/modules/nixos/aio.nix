{ lib, config, ... }:
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

  config = mkIf cfg.enable { programs.coolercontrol.enable = true; };
}
