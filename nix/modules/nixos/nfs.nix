{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.nfs;
in
{
  options = {
    modules.nixos.nfs = {
      enable = mkEnableOption "nfs";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nfs-utils ];

    services.rpcbind.enable = true;
  };
}
