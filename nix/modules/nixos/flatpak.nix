{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.flatpak;
in {
  options = { modules.nixos.flatpak = { enable = mkEnableOption "flatpak"; }; };

  config = mkIf cfg.enable { services.flatpak.enable = true; };
}
