{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.mangohud;
in {
  options = {
    modules.homemanager.mangohud = { enable = mkEnableOption "mangohud"; };
  };

  config = mkIf cfg.enable { programs.mangohud = { enable = true; }; };
}
