{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.teamviewer;
in {
  options = { modules.teamviewer = { enable = mkEnableOption "teamviewer"; }; };

  config = mkIf cfg.enable { services.teamviewer = { enable = true; }; };
}
