{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.docker;
in {
  options = { modules.docker = { enable = mkEnableOption "docker"; }; };

  config = mkIf cfg.enable { virtualisation.docker.enable = true; };
}
