{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.zerotier;
in
{
  options = {
    modules.nixos.zerotier = {
      enable = mkEnableOption "zerotier";
    };
  };

  config = mkIf cfg.enable { services.zerotierone.enable = true; };
}
