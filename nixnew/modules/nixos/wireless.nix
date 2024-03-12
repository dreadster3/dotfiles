{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nixos.wireless;
in {
  options = {
    modules.nixos.wireless = { enable = mkEnableOption "Wireless networking"; };
  };

  config = mkIf cfg.enable { networking = { wireless = { enable = true; }; }; };
}
