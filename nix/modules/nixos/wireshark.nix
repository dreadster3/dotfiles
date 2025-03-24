{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.wireshark;
in {
  options = {
    modules.nixos.wireshark = { enable = mkEnableOption "wireshark"; };
  };

  config = mkIf cfg.enable { programs.wireshark = { enable = true; }; };
}
