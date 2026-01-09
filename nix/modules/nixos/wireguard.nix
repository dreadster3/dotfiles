{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.wireguard;
in
{
  options = {
    modules.nixos.wireguard = {
      enable = mkEnableOption "wireguard";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wireguard-tools ];
  };
}
