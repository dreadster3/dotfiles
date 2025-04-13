{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.printing;
in {
  options = {
    modules.nixos.printing = { enable = mkEnableOption "printing"; };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    services.printing.drivers = with pkgs; [ hplipWithPlugin ];
  };
}
