{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.zerotier;
in {
  options = { modules.zerotier = { enable = mkEnableOption "zerotier"; }; };

  config = mkIf cfg.enable { services.zerotierone.enable = true; };
}
