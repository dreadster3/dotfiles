{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.docker;
in {
  options = { modules.nixos.docker = { enable = mkEnableOption "docker"; }; };

  config = mkIf cfg.enable { virtualisation.docker.enable = true; };
}
