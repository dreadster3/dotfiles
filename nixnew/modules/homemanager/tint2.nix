{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.tint2;
in {
  options = {
    modules.homemanager.tint2 = { enable = mkEnableOption "tint2"; };
  };

  config = mkIf cfg.enable {
    programs.tint2 = {
      enable = true;
      extraConfig = builtins.readFile ../../../configurations/tint2/tint2rc;
    };
  };
}
