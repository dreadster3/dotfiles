{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.wireless;
in {
  options = {
    modules.wireless = { enable = mkEnableOption "Wireless networking"; };
  };

  config = mkIf cfg.enable { networking = { wireless = { enable = true; }; }; };
}
