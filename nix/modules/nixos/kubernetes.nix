{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.kubernetes;
in {
  options = { modules.nixos.kubernetes = { enable = mkEnableOption "k3s"; }; };

  config = mkIf cfg.enable {
    networking.firewall = { allowedTCPPorts = [ 6443 ]; };

    services.k3s = {
      enable = true;
      role = "server";
    };
  };
}
