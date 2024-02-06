{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.flatpak;
in {
  options = { modules.flatpak = { enable = mkEnableOption "flatpak"; }; };

  config = mkIf cfg.enable { services.flatpak.enable = true; };
}
