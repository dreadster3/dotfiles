{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nixos.network;
in {
  options = {
    modules.nixos.network = { enable = mkEnableOption "Wireless networking"; };
  };

  config = mkIf cfg.enable {
    programs.nm-applet.enable = true;

    networking = {
      networkmanager.enable = true;
      firewall.enable = true;
      firewall.allowPing = false;
    };
  };
}
